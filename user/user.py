from flask import Blueprint, jsonify, request, make_response
from config.connection import db
from sqlalchemy import text
from middleware.auth import token_required
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime
import os

user_bp = Blueprint('user_bp', __name__)

@user_bp.route('', methods=['GET'])
@token_required
def get_profile(current_user):
    return jsonify({
        "id": current_user.id,
        "firstname": current_user.firstname,
        "lastname": current_user.lastname,
        "email": current_user.email,
        "message": f"Hola {current_user.firstname}, acceso concedido"
    }), 200
    
@user_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    firstname = data.get('firstname')
    lastname = data.get('lastname')
    email = data.get('email')
    password = data.get('password')
    
    if not all([firstname, lastname, email, password]):
        return jsonify({"error": "Todos los campos son obligatorios"}), 400
    
    try:
        check_query = text("SELECT id FROM users WHERE email = :email")
        existing_user = db.session.execute(check_query, {"email": email}).fetchone()
        
        if existing_user:
            return jsonify({"error": "Email ya registrado"}), 400
        
        hashed_password = generate_password_hash(password)
        
        insert_query = text("""
            INSERT INTO users (firstname, lastname, email, password_hash) 
            VALUES (:fname, :lname, :email, :pass)
        """)
        
        db.session.execute(insert_query, {
            "fname": firstname,
            "lname": lastname,
            "email": email,
            "pass": hashed_password
        })
        
        db.session.commit()
        return jsonify({"message": "Usuario registrado con exito"}),201
    
    except Exception as e:
        db.session.rollback()
        print(f"Error en registro: {e}")
        return jsonify({"error": "Error al registrar el nuevo usuario"}), 500
    
@user_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    
    if not email or not password:
            return jsonify({"error": "Faltan coincidencias"})
    
    try:
        query = text("SELECT * FROM users WHERE email = :email")
        user = db.session.execute(query, {"email": email}).fetchone()
        
        if not user:
            return jsonify({"error": "Usuario no encontrado"}), 401
        
        if not check_password_hash(user.password_hash, password):
            return jsonify({"error": "Credenciales invalidas"}), 401
        
        token = jwt.sign({
            'id': user.id,
            'email': user.email,
            'exp': datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(hours=2)
        }, os.getenv('JWT_SECRET', 'MiClaveSuperSecretaYMuyLarga123!'), algorithm="HS256")
        
        response = make_response(jsonify({
            "message": "Login exitoso desde Python",
            "user": {"firstname": user.firstname, "email": user.email}
        }))
        
        response.set_cookie(
            'access_token', 
            token, 
            httponly=True,
            samesite='Lax',
            max_age=7200 # 2 horas
        )
    
        return response
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@user_bp.route('/logout', methods=['POST'])
def logout():
    response = make_response(jsonify({"message": "Sesión cerrada"}))
    response.set_cookie('access_token', '', expires=0) # Borramos la cookie
    return response