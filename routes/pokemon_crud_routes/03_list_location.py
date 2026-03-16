from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text

location_bp = Blueprint('location_bp', __name__)

@location_bp.route('/rarity', methods=['GET'])
def get_rarity():
    try:
        
        query = text("""
                     SELECT location_id AS id, location_name AS name 
                     FROM pokemon_database.location
                     """)
        
        result = db.session.execute(query)
        
        location_list = [
            {"id": row.id, "name": row.name} 
            for row in result
        ]
        
        return jsonify(location_list), 200
        
    except Exception as e:
        print(f"Ha ocurrido un error en la peticion: {e}")
        return jsonify({"ERROR": "no se pudo leer la lista", "Detalles": str(e)}), 500