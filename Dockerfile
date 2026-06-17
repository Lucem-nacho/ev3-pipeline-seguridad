FROM python:3.9-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar dependencias e instalarlas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código vulnerable
COPY . .

# Inicializar la base de datos (crea database.db)
RUN python create_db.py

# Exponer el puerto
EXPOSE 5000

# Variable de entorno para decirle a Flask qué archivo ejecutar
ENV FLASK_APP=vulnerable_app.py

# Ejecutar la app permitiendo conexiones externas
CMD ["flask", "run", "--host=0.0.0.0"]  