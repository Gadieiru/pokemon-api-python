# Pokémon Search Backend v2

### Repositorio Frontend: 

El núcleo operativo de la Pokédex: una API RESTful de alto rendimiento forjada en **Python y Flask**, diseñada bajo principios de arquitectura limpia y modular. Implementa consultas maestras optimizadas en **MySQL** para garantizar un buscador de Pokémon ágil, escalable y con tolerancia a fallos.

## Características de Ingeniería
*   **Separación de Responsabilidades (SoC):** Arquitectura estructurada mediante módulos independientes de enrutamiento, middlewares de control y utilitarios.
*   **Seguridad y Autenticación:** Protección de endpoints privados mediante validación de tokens **JWT** y esquemas de control de acceso distribuidos en middlewares.
*   **Criptografía Avanzada:** Registro e inicio de sesión seguro con hashing criptográfico de contraseñas mediante **Bcrypt**.
*   **Persistencia Relacional Normalizada:** Base de datos MySQL optimizada para mitigar la latencia de consultas concurrentes en búsquedas complejas.

## 🛠️ Stack Tecnológico
*   **Lenguaje:** Python 3.10+ (100% del proyecto)
*   **Framework:** Flask
*   **Base de Datos:** MySQL
*   **Seguridad:** PyJWT, Bcrypt
*   **Control de Versiones:** Git (Metodología Git Feature Branching)

## Estructura del Proyecto
*   `config/`: Inicialización de servicios y adaptadores de bases de datos.
*   `middleware/`: Capas de interceptación para seguridad, CORS y validación de tokens.
*   `routes/`: Definición de endpoints y exposición de la API RESTful.
*   `user/`: Dominio encargado de la lógica de negocio, autenticación y sesiones.
*   `utils/`: Helpers lógicos y estandarización de respuestas del servidor.
*   `dumpsPy/`: Scripts de inicialización y esquemas relacionales SQL.

## Inicialización en Entorno Local

Sigue estos pasos lógicos para desplegar el servidor de desarrollo en tu computadora:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com
   cd pokemon-search-backend-v2
   ```

2. **Configurar el Entorno Virtual (Venv):**
   ```bash
   python -m venv venv
   # En Windows:
   venv\Scripts\activate
   # En Linux/Mac:
   source venv/bin/activate
   ```

3. **Instalar Dependencias:**
   ```bash
   pip install -r requeriments.txt
   ```

4. **Variables de Entorno (.env):**
   Crea un archivo `.env` en la raíz y configura tus credenciales de acceso:
   ```env
   FLASK_ENV=development
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=tu_contraseña
   DB_NAME=pokemon_db
   JWT_SECRET_KEY=tu_firma_secreta
   ```

5. **Ejecutar el Servidor:**
   ```bash
   python app.py
   ```
   El servidor backend se levantará por defecto en `http://127.0.0.1:5000`.

---
Desarrollador con criterio técnico por **Robert Gadiel Fuenmayor Romero**.
