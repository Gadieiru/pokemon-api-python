import os
import time
from werkzeug.utils import secure_filename
from werkzeug.datastructures import FileStorage
from flask import request, jsonify

upload_folder = os.path.join(os.getcwd(), 'static/pokemons')
allowed_extensions = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename: str):
    return (
    '.' in filename and 
    filename.rsplit('.', 1)[1].lower() in allowed_extensions
)
        
def save_pokemon_img(file: FileStorage):
    if file and allowed_extensions(file.filename):
        ext = file.filename.rsplit('.',1)[1].lower
        new_filename = f"{int(time.time())}.{ext}"
        
        final_name = secure_filename(new_filename)
        file_path = os.path.join(upload_folder)
        
        file.save(file_path)
        
        return f"/static/pokemons/{final_name}"
    return None