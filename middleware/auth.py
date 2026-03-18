import jwt
import os
from functools import wraps
from flask import request, jsonify
from config.connection import db 
from sqlalchemy import text

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.cookies.get('access_token')
    
        if not token and 'Authorization' in request.headers:
            auth_header = request.headers['Authorization']
        if 'Bearer' in auth_header:
            token = auth_header.split(" ")[1]
        
        if not token:
            return jsonify({"error": "No has iniciado sesion"}), 401
        
        try:
            secret = os.getenv('JWT_SECRET', 'clave_secreta_super_segura_123')
            data = jwt.decode(token, secret, algorithms=["HS256"])
            
            query = text("SELECT id, firstname, lastname, email FROM users WHERE id = :id")
            user_data = db.session.execute(query, {"id": data['id']}).fetchone()
            
            if not user_data:
                return jsonify({"error": "Usuario no encontrado"}), 401
            
            current_user = data   
            
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Tu sesion ha expirado."}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Sesion invalida"}),401
        
        return f(current_user, *args, **kwargs)
    
    return decorated

