# README

Trail scout is a backend API in rails that consumes the Google Geolocation API and Hiking Trails data API
- https://www.hikingproject.com/data
- https://maps.googleapis.com/maps/api/geocode.

It functions as a pass through and will accept any of the optional arguements the Hiking Trails API accepts but uses the Geocoding API to allow users to pass in city names rather than lat/lng. The reason it does this is it records every search that is performed through it and using cities rather than lat/lng standardizes the data. It's two endpoints are the trails index to return parsed down trail information to users, and the trail_searches index endpoint to provide information about the searches that have been performed


## Endpoints

This api is hosted at http://trail-scout22.herokuapp.com, endpoints should then be formatted: `http://trail-scout22.herokuapp.com/api/v1/trails`

### GET api/v1/trails
Returns a list of hiking trails near a specified city in the following format:
```javascript
[
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
``` 
###### Required Params
- address, A city name, formatted 'Denver, CO'

###### Optional Params
- maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200. 
- maxResults - Max number of trails to return. Default: 10. Max: 500.
- sort - Values can be 'quality', 'distance'. Default: quality.
- minLength - Min trail length, in miles. Default: 0 (no minimum).
- minStars - Min star rating, 0-4. Default: 0.

### GET api/v1/trail_searches
Returns stats about all recorded searches. Only serializes search information that a user provided. Returns in the following format:
```javascript
GET api/v1/trail_searches?order=max_results&direction=desc&limit=3

  [
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
```
###### Optional Params
- city - formatted `denver, co` returns exact matches for the provided city 
- order - sorts the returned trail searches based on a given order, acccepts `min_ength`, `min_stars`, `max_results`, `max_distance`. Defaults to created_at if not provided.
- direction - `asc` or `desc`, orders the returned trail searches in the given direction
- sort - returns trail searches where a sort type was provided, accepts `quality` and `distance`. Returns null values last.
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
