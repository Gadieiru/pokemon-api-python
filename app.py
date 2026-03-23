import os
from flask import Flask
from flask_cors import CORS
from config.connection import db, init_db


from user.user import user_bp
from routes.pokemon_crud_routes.pokemon_crud import crud_bp
from routes.pokemon_search_routes.pokemon import pokemon_db

app = Flask(__name__)

app.config['SECRET_KEY'] = os.getenv('JWT_SECRET', 'MiClaveSuperSecretaYMuyLarga123!')

app.config['SESSION_COOKIE_SAMESITE'] = 'Lax' 
app.config['SESSION_COOKIE_SECURE'] = False

#De esta forma CORS permite el envio de cookies desde el fontend.
CORS(app, supports_credentials=True)

init_db(app)
#Registrando el blueprint
app.register_blueprint(pokemon_db, url_prefix='/pokemon')
app.register_blueprint(user_bp, url_prefix='/auth') 
app.register_blueprint(crud_bp, url_prefix='/api')

if __name__ == '__main__':
    puerto_env = int(os.getenv('PORT', 3000))
    
    print(f'--ESCUCHANDO EN EL PUERTO: {puerto_env}--')
    app.run(debug=True, port=puerto_env)