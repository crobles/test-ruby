# Usa la imagen oficial de Ruby 3.2.2
FROM ruby:3.2.2

# Instala dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libvips \
    && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY Gemfile Gemfile.lock ./

# Instala las gemas
RUN bundle install

# Copia el resto de la aplicación
COPY . .

# Crea y migra la base de datos SQLite
RUN rails db:create db:migrate

# En Rails 8 con Importmap no necesitamos precompilar assets
# Los assets se sirven directamente

# Expone el puerto 3000
EXPOSE 3000

# Script de entrada
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Comando por defecto
CMD ["rails", "server", "-b", "0.0.0.0"]