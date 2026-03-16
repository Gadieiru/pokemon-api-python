from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text

pokemon_db = Blueprint('pokemon_db', __name__) 

@pokemon_db.route('/search', methods=['GET'])
def get_pokemons():
    try:
        
        #Con esto hacemos las peticiones de busqueda reemplazando en LIKE los ? por :like_term y por :exact en la busqueda del pokemon_name 
        search_term =  request.args.get('search', '')
        like_term = f"%{search_term}%"
        
        query = text("""
                SELECT 
                     p.pokemon_id, 
                     r.rarity_name, 
                     p.description, 
                     p.initial_happiness, 
                     p.pokemon_name, 
                     p.pokemon_img, 
                     GROUP_CONCAT(DISTINCT t.type_name SEPARATOR '/') as types, 
                     GROUP_CONCAT(DISTINCT l.location_name SEPARATOR '/') as locations          
                FROM pokemon_database.pokemon p 
                LEFT JOIN rarity r ON p.rarity_id = r.rarity_id 
                LEFT JOIN pokemon_types pt ON p.pokemon_id = pt.pokemon_id 
                LEFT JOIN types t ON pt.types_id = t.types_id 
                LEFT JOIN pokemon_location pl ON p.pokemon_id = pl.pokemon_id 
                LEFT JOIN location l ON pl.location_id = l.location_id
                WHERE p.pokemon_name LIKE :like_term 
                GROUP BY p.pokemon_id 
                ORDER BY 
                  CASE 
                    WHEN p.pokemon_name = :exact 
                    THEN 1 WHEN p.pokemon_name LIKE :like_term 
                    THEN 2 
                    ELSE 3 
                  END, 
                p.pokemon_name ASC""") 
        
        resultado = db.session.execute(query, {
            "like_term": like_term,
            "exact": search_term
        })
        
        datos = [dict(row._mapping) for row in resultado]
        
        return jsonify(datos), 200
        
    except Exception as e:
        print(f"Error en la peticion: {e}")
        return jsonify({"ERROR": "No se pudo leer la tabla", "detalles": str(e)}), 500
        

#feat: (nueva funcionalidad) -> git commit -m "feat: endpoint para obtener pokemon por tipo"

#fix: (corrección de un error) -> git commit -m "fix: error en la conexión a MySQL"

#refactor: (mejora de código sin cambiar funcionalidad) -> git commit -m "refactor: optimización de la lógica en la API REST"

#docs: cuando es documentacion.