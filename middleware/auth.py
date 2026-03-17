import jwt
import os
from functools import wraps
from flask import request, jsonify

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.cookies.get('access_token')
    
        if not token:
            return jsonify({"error": "No has iniciado sesion"}), 401
        
        try:
            data = jwt.decode(
                token,
                os.getenv('JWT_SECRET','clave_secreta_provisoria'),
                algorithms=["HS256"]
            )
            current_user = data   
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Tu sesion ha expirado."}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Sesion invalida"}),401
        
        return f(current_user, *args, **kwargs)
    
    return decorated

