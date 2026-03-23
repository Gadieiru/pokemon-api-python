import os
import json
from config.connection import db
from flask import Blueprint, jsonify, request
from sqlalchemy import text
from middleware.auth import token_required
from middleware.upload import save_pokemon_img 
from utils.file_handler import delete_file

crud_bp = Blueprint('crud_bp', __name__)

#Crear
@crud_bp.route('/crud', methods=['GET'])
@token_required
def get_crud(current_user):
    try:
        if not current_user.id:
            return jsonify({"error": "Identidad de usuario no valida"}), 403
        
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
                    WHERE p.user_id = :u_id 
                    GROUP BY p.pokemon_id
                     """)
        result = db.session.execute(query,  {"u_id": current_user.id})
        
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
        return jsonify({"error": "No pudo procesar la solicitud del usuario"}), 500
    
#Leer   
@crud_bp.route('', methods=['POST'])
@token_required
def create_pokemons(current_user):
    #pokemon
    pokemon_name = request.form.get('pokemon_name')
    rarity_id = request.form.get('rarity_id')
    file = request.files.get('pokemon_img')
        
    if not pokemon_name or not rarity_id:
        return jsonify({"error": "Faltan campos"}),400
    
    try:
        count_query = text("SELECT COUNT(*) FROM pokemon WHERE user_id = :u_id")
        total_count = db.session.execute(count_query, {"u_id": current_user.id}).scalar()

        if total_count >= 50: # Límite de 50 pokemon por usuario
            return jsonify({"error": "Has alcanzado el límite máximo de tu colección"}), 402
    
        img_path = save_pokemon_img(file) if file else None
        
        insert_pk =text("INSERT INTO pokemon (pokemon_name, rarity_id, pokemon_img, user_id) VALUES (:name, :rarity, :image, :u_id)")
        
        db.session.execute(insert_pk, {
            "name": pokemon_name, 
            "rarity": rarity_id, 
            "image": img_path,
            "u_id": current_user.id
            })
        
        new_id = db.session.execute(text("SELECT LAST_INSERT_ID()")).scalar()
        
        type_ids = json.loads(request.form.get('type_id', '[]'))
        for tid in type_ids:
            db.session.execute(text("INSERT INTO pokemon_types (pokemon_id, types_id) VALUES (:pid, :tid)"), {"pid": new_id, "tid": tid}) 
            
        loc_ids = json.loads(request.form.get('location_id', '[]'))
        for lid in loc_ids:
            db.session.execute(text("INSERT INTO pokemon_location (pokemon_id, location_id) VALUES (:pid, :lid)"), {"pid": new_id, "lid": lid})
        
        db.session.commit()
        
        return jsonify({
            "id": new_id, 
            "message": "Pokemon creado con exito"
            }), 201
    
    except Exception as e:
        db.session.rollback()
        print("error en la creacion")
        return jsonify({"error": str(e)}), 500
    
#Actualizar    
@crud_bp.route('/<int:pokemon_id>', methods=['PUT'])
@token_required
def update_pokemon(current_user, pokemon_id):
        name = request.form.get('pokemon_name')
        rarity = request.form.get('rarity_id')
        happiness = request.form.get('initial_happiness')
        file = request.files.get('pokemon_img')
               
        try:
            search_query = text("SELECT pokemon_img FROM pokemon WHERE pokemon_id = :id AND user_id = :u_id") 
            current_data = db.session.execute(search_query, {"id": pokemon_id, "u_id": current_user.id}).fetchone()
        
            if not current_data:
                return jsonify({"error": "Pokémon no encontrado o acceso denegado"}), 404
        
            old_img_path = current_data[0]
            new_img_path = old_img_path
             
            if file:
                new_img_path = save_pokemon_img(file)
                if old_img_path:
                    delete_file(old_img_path)
                    
            update_sql = text("""
                              UPDATE pokemon
                              SET pokemon_name = :name, rarity_id = :rarity,
                                  initial_happiness = :happiness, pokemon_img = :image
                              WHERE pokemon_id = :id AND user_id = :u_id
                              """)
            
            db.session.execute(update_sql, {
            "name": name, 
            "rarity": rarity, 
            "happiness": happiness, 
            "image": new_img_path, 
            "id": pokemon_id,
            "u_id": current_user.id
        })
            
            db.session.execute(text("DELETE FROM pokemon_types WHERE pokemon_id = :id"), {"id": pokemon_id})
            type_ids = json.loads(request.form.get('type_id', '[]'))
            for tid in type_ids:
                db.session.execute(text("INSERT INTO pokemon_types (pokemon_id, types_id) VALUES (:pid, :tid)"), {"pid": pokemon_id, "tid": tid})
                
            db.session.execute(text("DELETE FROM pokemon_location WHERE pokemon_id = :id"), {"id": pokemon_id})
            location_ids = json.loads(request.form.get('location_id', '[]'))
            for lid in location_ids:
                db.session.execute(text("INSERT INTO pokemon_location (pokemon_id, location_id) VALUES (:pid, :lid)"), {"pid": pokemon_id, "lid": lid})
                
            db.session.commit()
            return jsonify({"message":"Actualizado correctamente"}), 200
    
        except Exception as e:
            db.session.rollback()
            print(f"Error: {e}")
            return jsonify({"error": str(e)})    
                 
#Borrar    
@crud_bp.route('/<int:pokemon_id>', methods=['DELETE'])
@token_required
def delete_pokemon(current_user, pokemon_id):
    try:
        search_query = text("SELECT pokemon_img FROM pokemon WHERE pokemon_id = :id AND user_id = :u_id")
        pokemon = db.session.execute(search_query, {"id": pokemon_id, "u_id": current_user.id}).fetchone()
    
        if not pokemon: 
            return jsonify({"error": "Pokemon no encontrado"})
        
        img_to_delete = pokemon[0] 
    
        db.session.execute(text("DELETE FROM pokemon_types WHERE pokemon_id = :id"), {"id": pokemon_id})
        db.session.execute(text("DELETE FROM pokemon_location WHERE pokemon_id = :id"), {"id": pokemon_id})
    
        db.session.execute(text("DELETE FROM pokemon WHERE pokemon_id = :id AND user_id = :u_id"), {"id": pokemon_id, "u_id": current_user.id})
    
        db.session.commit()
    
        if img_to_delete:
            delete_file(img_to_delete)
        
        return jsonify({"message": f"Pokemon {pokemon_id} y su imagen fueron eliminados"}), 200
    
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500 
        