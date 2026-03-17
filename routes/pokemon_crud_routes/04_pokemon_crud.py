import os
import json
from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text
from middleware.auth import token_required
from middleware.upload import save_pokemon_img 
from utils.file_handler import delete_file

crud_bp = Blueprint('crud_bp', __name__)

@crud_bp.route('/crud', methods=['GET'])
def get_crud():
    try:
        
        query = text("""
                     SELECT 
                     p.pokemon_id, 
                     p.pokemon_name, 
                     p.initial_happiness, 
                     p.rarity_id, 
                     r.rarity_name, 
                           GROUP_CONCAT(DISTINCT t.type_name) AS types, 
                           GROUP_CONCAT(DISTINCT l.location_name) AS location, GROUP_CONCAT(DISTINCT t.types_id) AS type_ids, 
                           GROUP_CONCAT(DISTINCT l.location_id) AS locations,
                           p.pokemon_img 
                    FROM pokemon_database.pokemon p 
                    JOIN rarity r ON p.rarity_id = r.rarity_id 
                    LEFT JOIN pokemon_types pt ON p.pokemon_id = pt.pokemon_id 
                    LEFT JOIN types t ON pt.types_id = t.types_id 
                    LEFT JOIN pokemon_location pl ON p.pokemon_id = pl.pokemon_id 
                    LEFT JOIN location l ON pl.location_id = l.location_id 
                    GROUP BY p.pokemon_id
                     """)
        result = db.session.execute(query)
        
        pokemons = []
        for row in result:
            pokemons.append({
                "pokemon_id": row.pokemon_id,
                "pokemon_name": row.pokemon_name,
                "initial_happiness": row.initial_happiness,
                "rarity_name": row.rarity_name,
                "types": row.types.split(',') if row.types else [],
                "locations": row.location.split(',') if row.location else [],
                "pokemon_img": row.pokemon_img
            })
        return jsonify(pokemons), 200
        
    except Exception as e:
        print(f"Ha ocurrido un error en la peticion: {e}")
        return jsonify({"error": str(e)}), 500
    
@crud_bp.route('', methods=['POST'])
@token_required
def create_pokemons(current_user):
    pokemon_name = request.form.get('pokemon_name')
    rarity_id = request.form.get('rarity_id')
    file = request.files.get('pokemon_img')
    
    img_path = save_pokemon_img(file if file else None)
        
    if not pokemon_name or not rarity_id:
        return jsonify({"error": "Faltan campos"}),400
    
    try:
        insert_pk =text("INSERT INTO pokemon (pokemon_name, rarity_id, pokemon_img) VALUES (:name, :rarity, :image)")
        db.session.execute(insert_pk, {"name": pokemon_name, "rarity": rarity_id, "img": img_path})
        db.session.commit()
        
        new_id = db.session.execute(text("SELECT LAST_INSERT_ID()")).scalar()
        
        type_ids = json.loads(request.form.get('type_id', '[]'))
        for tid in type_ids:
            db.session.execute(text("INSERT INTO pokemon_types (pokemon_id, types_id) VALUES (:pid, :tid)"), {"pid": new_id, "tid": tid}) 
            
        loc_ids = json.loads(request.form.get('location_id', '[]'))
        for lid in loc_ids:
            db.session.execute(text("INSERT INTO pokemon_location (pokemon_id, location_id) VALUES (:pid, :lid)"), {"pid": new_id, "lid": lid})
        
        db.session.commit()
        return jsonify({"id": new_id, "message": "Creado con exito"}), 201
    except Exception as e:
        db.session.rollback()
        print("error en la creacion")
        return jsonify({"error": str(e)}), 500
    
@crud_bp.route('/<int:pokemon_id>', methods=['DELETE'])
@token_required
def delete_pokemon(current_user, pokemon_id):
    try:
        search_query = text("SELECT pokemon_img FROM pokemon WHERE pokemon_id = :id")
        pokemon = db.session.execute(search_query, {"id": pokemon_id}).fetchone()
    
        if not pokemon: 
            return jsonify({"error": "Pokemon no encontrado"})
        
        img_to_delete = pokemon[0] 
    
        db.session.execute(text("DELETE FROM pokemon_types WHERE pokemon_id = :id"), {"id": pokemon_id})
        db.session.execute(text("DELETE FROM pokemon_location WHERE pokemon_id = :id"), {"id": pokemon_id})
    
        db.session.execute(text("DELETE FROM pokemon WHERE pokemon_Id = :id"), {"id": pokemon_id})
    
        db.session.commit()
    
        if img_to_delete:
            delete_file(img_to_delete)
        
        return jsonify({"message": f"Pokemon {pokemon_id} y su imagen fueron eliminados"}), 200
    
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500 
        