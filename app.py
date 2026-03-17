import os
from flask import Flask
from flask_cors import CORS
from config.connection import db, init_db
from routes.pokemon_search_routes.pokemon import pokemon_db

app = Flask(__name__)
#De esta forma CORS permite el envio de cookies desde el fontend.
CORS(app, supports_credentials=True)

init_db(app)
#Registrando el blueprint
app.register_blueprint(pokemon_db, url_prefix='/pokemon')

if __name__ == '__main__':
    puerto_env = int(os.getenv('PORT', 3000))
    
    print(f'--ESCUCHANDO EN EL PUERTO: {puerto_env}--')
    app.run(debug=True, port=puerto_env)