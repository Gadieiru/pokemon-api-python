import os

uploads_dir = os.path.join(os.getcwd(), "static")

def delete_file(relative_path: str):
    if not relative_path: 
        return
    
    path_to_clean = relative_path.replace('/static/', '')
    
    full_path = os.path.join(uploads_dir, path_to_clean)
    
    try:
        if os.path.exist(full_path):
            os.remove(full_path)
            print(f"Archivo eliminado fisicamente: {full_path}")
    except Exception as e:
        print(f"Error al intentar borrar el archivo: {relative_path}: {e}")