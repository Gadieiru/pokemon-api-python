from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text

types_bp = Blueprint('types_bp', __name__)

@types_bp.route('/type', methods=['GET'])
def get_types():
    try:
        
        query = text("""
                     SELECT types_id AS id, type_name AS name 
                     FROM pokemon_database.types
                     """)
        
        result = db.session.execute(query)
        
        types_list = [
            {"id": row.id, "name": row.name} 
            for row in result
        ]
        
        return jsonify(types_list), 200
        
    except Exception as e:
        print(f"Ha ocurrido un error en la peticion: {e}")
        return jsonify({"ERROR": "no se pudo leer la lista", "Detalles": str(e)}), 500
    