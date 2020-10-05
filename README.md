# README

Trail scout is a backend API in rails that consumes the Google Geolocation API and Hiking Trails data API
- https://www.hikingproject.com/data
- https://maps.googleapis.com/maps/api/geocode.

It functions as a pass through and will accept any of the optional arguements the Hiking Trails API accepts but uses the Geocoding API to allow users to pass in city names rather than lat/lng. The reason it does this is it records every search that is performed through it and using cities rather than lat/lng standardizes the data. It's two endpoints are the /trails index to return parsed down trail information to users, and the /trail_searches index endpoint to provide information about the searches that have been performed


## Endpoints

### GET api/v1/trails
Returns a list of hiking trails near a specified city in the following format:
```javascript
{
  "olympians":
    [
      {
        "name": "Maha Abdalsalam",
        "team": "Egypt",
        "age": 18,
        "sport": "Diving"
        "total_medals_won": 0
      },
      {
        "name": "Ahmad Abughaush",
        "team": "Jordan",
        "age": 20,
        "sport": "Taekwondo"
        "total_medals_won": 1
      },
      {...}
    ]
}
``` 
###### Required Params
- city A city name, formatted 'Denver, CO'

###### Optional Params
- maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200. 
- maxResults - Max number of trails to return. Default: 10. Max: 500.
- sort - Values can be 'quality', 'distance'. Default: quality.
- minLength - Min trail length, in miles. Default: 0 (no minimum).
- minStars - Min star rating, 0-4. Default: 0.

### GET api/v1/trail_searches
Returns stats about all olympians in the format:
```javascript
  {
    "olympian_stats": {
      "total_competing_olympians": 3120
      "average_weight:" {
        "unit": "kg",
        "male_olympians": 75.4,
        "female_olympians": 70.2
      }
      "average_age:" 26.2
    }
  }
```
###### Optional Params
- city - formatted `denver, co` returns exact matches for the provided city 
- order - sorts the returned trail searches based on a given order, acccepts `min_ength`, `min_stars`, `max_results`, `max_distance`. Defaults to created_at if not provided.
- direction - `asc` or `desc`, orders the returned trail searches in the given direction
- sort - returns trail searches where a sort type was provided, accepts `quality` and `distance`
- limit - limit number of returned results, default 10

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
