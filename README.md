# Calculadora de Remuneración con Docker

incluye configuración Docker para ejecutar la aplicación sin necesidad de instalar Ruby, Rails o dependencias localmente.

### 1. Clonar el repositorio

```bash
git clone [URL-del-repositorio]
cd payroll-calculator-app
```

### 2. Ejecutar la aplicación

```bash
docker-compose up --build
```

### 3. Acceder a la aplicación

Abre tu navegador en: http://localhost:3000

## Comandos Útiles

### Ejecutar en segundo plano

```bash
docker-compose up -d
```

### Ver logs

```bash
docker-compose logs -f
```

### Detener la aplicación

```bash
docker-compose down
```

### Ejecutar tests

```bash
docker-compose --profile test up test
```

### Ejecutar RSpec

```bash
# Todos los tests
docker-compose exec web bundle exec rspec

# Tests específicos
docker-compose exec web bundle exec rspec spec/system/payroll_calculation_spec.rb
```

### Estructura de archivos Docker

- `Dockerfile` - Configuración de la imagen
- `docker-compose.yml` - Orquestación de servicios
- `docker-entrypoint.sh` - Script de inicialización
- `.dockerignore` - Archivos excluidos del build

### La aplicación no inicia

```bash
# Reconstruir la imagen
docker-compose build --no-cache
docker-compose up
```

### Limpiar volúmenes

```bash
docker-compose down -v
docker system prune -f
```

## Notas

- El puerto 3000 está mapeado a localhost:3000
