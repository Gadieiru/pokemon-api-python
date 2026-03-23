from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text

rarity_bp = Blueprint('rarity_bp', __name__)

@rarity_bp.route('/rarity', methods=['GET'])
def get_rarity():
    try:
        
        query = text("""
                     SELECT rarity_id AS id, rarity_name AS name 
                     FROM pokemon_database.rarity
                     """)
        
        result = db.session.execute(query)
        
        rarity_list = [
            {"id": row.id, "name": row.name} 
            for row in result
        ]
        
        return jsonify(rarity_list), 200
        
    except Exception as e:
        print(f"Ha ocurrido un error en la peticion: {e}")
        return jsonify({"ERROR": "no se pudo leer la lista", "Detalles": str(e)}), 500
    