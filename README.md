## Run locally

### Create `.env` file and add
```
ACCUWEATHER_API_KEY=<your_api_key>
DB_HOST=localhost
DB_USERNAME=dummy
DB_PASSWORD=password
```
* Check db username and password in your local machine

## Or run with Docker

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
docker compose run web rake db:create db:migrate
```

#### 4. Send request
```
curl http://0.0.0.0:3000/api/v1/health
```
