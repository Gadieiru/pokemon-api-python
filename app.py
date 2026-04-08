import os
from flask import Flask
from flask_cors import CORS
from config.connection import db, init_db
from dotenv import load_dotenv
load_dotenv()


from user.user import user_bp
from routes.pokemon_crud_routes.pokemon_crud import crud_bp
from routes.pokemon_search_routes.pokemon import pokemon_db

from routes.pokemon_crud_routes.list_location import location_bp
from routes.pokemon_crud_routes.list_rarity import rarity_bp
from routes.pokemon_crud_routes.list_types import types_bp 

app = Flask(__name__)

CORS(app, 
     supports_credentials=True, 
     origins=["http://localhost:5173"],
     resources={r"/*": {"origins": "http://localhost:5173"}})

app.config['SECRET_KEY'] = os.getenv('JWT_SECRET', 'MiClaveSuperSecretaYMuyLarga123!')

app.config['SESSION_COOKIE_SAMESITE'] = 'Lax' 
app.config['SESSION_COOKIE_SECURE'] = False
app.config['SESSION_COOKIE_HTTPONLY'] = True
app.config['AUTH_COOKIE_NAME'] = 'access_token'


init_db(app)
#Registrando el blueprint
app.register_blueprint(pokemon_db, url_prefix='/pokemon')
app.register_blueprint(user_bp, url_prefix='/auth') 
app.register_blueprint(crud_bp, url_prefix='/api')

app.register_blueprint(location_bp, url_prefix='/list')
app.register_blueprint(rarity_bp, url_prefix='/list') 
app.register_blueprint(types_bp, url_prefix='/list')

if __name__ == '__main__':
    puerto_env = int(os.getenv('PORT', 3000))
    
    print(f'--ESCUCHANDO EN EL PUERTO: {puerto_env}--')
    app.run(debug=True, port=puerto_env)