# Accu Weather

**Accu Weather** is a Rails API Only for working with [AccuWeather API](https://developer.accuweather.com/).

It uses Postgres, Redis as a cache, and Swagger. This application is available to run in a Docker environment (see the instructions below).


## Usage

### I. Run locally

#### 1. Create `.env` file and add
```
ACCUWEATHER_API_KEY=aPmXW3zSMgsz4K84mkY8fVRokC5xkAZY # Or <your_api_key>
DB_HOST=localhost
DB_USERNAME=dummy
DB_PASSWORD=password
```
* Check db username and password in your local machine

#### 4. Setup DB
```
rails db:setup
```

#### 5. Start the server
```
rails s
```

#### 3. Try Swagger. Go to:
```
http://localhost:3000/api-docs
```

### II. Or run with Docker

#### 1. Build the image
```
docker compose build
```

OR generate the Rails skeleton app using
```
docker compose run --no-deps web rails new . --force --database=postgresql
```

#### 2. Run application
```
docker compose up
```

#### 3. Setup database
```
docker compose run web rails db:setup
```

#### 4. Change `swagger/v1/swagger.yaml:54` url to
```
servers:
- url: http://0.0.0.0:3000
```

#### 5. Send request
```
curl http://0.0.0.0:3000/api/v1/health
```
#### 6. Try Swagger. Go to:
```
http://0.0.0.0:3000/api-docs
```
