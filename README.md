# README

Trail scout is a backend API in rails that consumes the Google Geolocation API and Hiking Trails data API
- https://www.hikingproject.com/data
- https://maps.googleapis.com/maps/api/geocode.

It authenticates users by making them create an account with an email and password, then provides them an API key. They then use this api key to lookup trail information for a given city via a `trails` index. The app records information about their searches which can be accessed via a `trail_searches` index, or a user specific `user/trail_searches` index, which returns a users search history.


## Endpoints

This api is hosted at http://trail-scout22.herokuapp.com, endpoints should then be formatted: `http://trail-scout22.herokuapp.com/api/v1/trails`

### POST api/v1/users
User creation endpoint, requires an email and matching password and password_confirmation
```javascript
Request Params: {"email"=>"duvallp200@gmail.com", "password"=>"password", "password_confirmation"=>"password"

Response:
{
    "user": {
        "email": "duvallp201@gmail.com",
        "api_key": "fc410df89caedb0173df88e1a6ead742"
    }
}
```
### POST api/v1/sessions
Requires a valid user email and matching password 
```javascript
Request Params: {"email"=>"duvallp200@gmail.com", "password"=>"password"}

Response:
{
    "user": {
        "email": "duvallp201@gmail.com",
        "api_key": "fc410df89caedb0173df88e1a6ead742"
    }
}

``` 

### POST 

### GET api/v1/trails
Returns a list of hiking trails near a specified city in the following format:
```javascript
Request Params {"address" => "denver, co", "api_key" => "85b559b418ae6d670e1a10c390d6bf34", "limit" => "2"}

Response:
{
    "trails"[
        {
            "name": "City Park Loop",
            "summary": "An easy escape from the hustle and bustle of Denver's city limits.",
            "location": "Denver, Colorado",
            "url": "https://www.hikingproject.com/trail/7011837/city-park-loop",
            "length": 3.3,
            "distance": null,
            "stars": 3.8
        },
        {
            "name": "Denver Zoo",
            "summary": "A stroll through the Denver Zoo. Admission fees charged to access this trail",
            "location": "Denver, Colorado",
            "url": "https://www.hikingproject.com/trail/7018092/denver-zoo",
            "length": 2.6,
            "distance": null,
            "stars": 4.5
        }
    ]
}
``` 
###### Required Params
- address, A city name, formatted 'Denver, CO'
- api_key, the valid api_key of a user in the system

###### Optional Params
- maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200. 
- maxResults - Max number of trails to return. Default: 10. Max: 500.
- sort - Values can be 'quality', 'distance'. Default: quality.
- minLength - Min trail length, in miles. Default: 0 (no minimum).
- minStars - Min star rating, 0-4. Default: 0.

### GET api/v1/trail_searches
Returns stats about all recorded searches. Only serializes search information that a user provided. Returns in the following format:
```javascript
Request Params {"order" => "max_results", "direction" => "desc", "limit" => "3"}

Response:
{
    "trail_searches"[
        {
            "city": "denver, co",
            "max_results": 2,
            "sort": "quality"
        },
        {
            "city": "denver, co",
            "max_results": 1,
            "sort": "quality"
        },
        {
            "city": "denver, co",
            "sort": "quality"
        }
    ],
    "meta": {
        "current_page": 1,
        "next_page": null,
        "prev_page": null,
        "total_pages": 1,
        "total_count": 8
    }
}
```
###### Optional Params
- city - formatted `denver, co` returns exact matches for the provided city 
- order - sorts the returned trail searches based on a given order, acccepts `min_length`, `min_stars`, `max_results`, `max_distance`. Defaults to created_at if not provided.
- direction - `asc` or `desc`, orders the returned trail searches in the given direction
- sort - returns trail searches where a sort type was provided, accepts `quality` and `distance`. Returns null values last.
- limit - limit number of returned results, default 10

### GET api/v1/users/trail_searches
Takes a users api_key and returns that users search history
```javascript
Request Params: {"api_key" => "85b559b418ae6d670e1a10c390d6bf34"}


Response:
{
    "trail_searches"[
        {
            "city": "denver, co",
            "max_results": 2,
            "sort": "quality"
        },
        {
            "city": "denver, co",
            "max_results": 1,
            "sort": "quality"
        },
        {
            "city": "denver, co",
            "sort": "quality"
        }
    ]
}
```
###### Required Params
- api_key, the valid api_key of a user in the system


## Running on your local machine
1. `$ git clone git@github.com:Patrick-Duvall/trail-scout.git`
1. `$ bundle`
1. `$ add your API keys to `.env`: 
```yml
GOOGLE_PLACES_KEY: <your Google geocoding API key>
HIKING_TRAILS_KEY: <your Hiking Project API key>
```
1. `$ rails db:create`
1. Run the test suite with `$ bundle exec rspec`
1. Start a local server with `$ rails s` -- access in your browser or Postman at `localhost:3000`

## Built using
- Rails 5.2.x 
- Ruby 2.6.x
- PostgreSQL database
