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

# Expone el puerto 3000
EXPOSE 3000

# Comando por defecto
CMD ["rails", "server", "-b", "0.0.0.0"]