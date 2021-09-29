# Sweater Weather

> Sweater Weather is a 7-day solo project for Turing School's Back End Engineering Program

### Table of Contents
- [Sweater Weather](#sweater-weather)
- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Features](#features)
- [API Endpoints](#api-documentation)
- [Usage Examples](#usage-examples)
- [Tools Used](#tools-used)
- [How to Contribute](#how-to-contribute)
- [Personal Info](#personal-info)

## Overview

*Sweater Weather* is a Rails API that provides the information necessary to build a front-end application with access to MapQuest routing features and OpenWeather forecasts associated with potential road trips.

## Learning Goals

This project was intended as an exercise to practice:
- Exposing an API
- Aggregating and exposing data from external APIs
- API-based CRUD functionality
- API key generation; token-based authentication
- Building endpoints based on front end wireframes

## Features

Upon registration with an email address, users are provided with a unique API key. This key can then be used to plan a road trip through MapQuest's Route service, combined with OpenWeather's Onecall service to view predicted weather at their selected destination.

In addition, this app allows for:
- Keyword-based forecast searches by location using MapQuest's Geocode service
- Keyword-based background image searches using Pexels's Image service
- Session creation with user authentication
- API-key authentication
- Custom error-handling messages to control for sad paths/edge cases

## API Endpoints

| Feature                        | Endpoint                                       |
|--------------------------------|------------------------------------------------|
| Retrieve forecast for location | `GET  /api/v1/forecast?location={location}`    |
| Retrieve background image      | `GET  /api/v1/backgrounds?location={location}` |
| Create User                    | `POST /api/v1/users`                           |
| Login User                     | `POST /api/v1/sessions`                        |
| Create new Road Trip           | `POST /api/v1/road_trip`                       |

## Usage Examples

New Road Trip with travel time and predictive weather forecast
Endpoint: `POST /api/v1/road_trip`
JSON Body:
```json
{
    "origin": "Vista, CA",
    "destination": "Denver, CO",
    "api_key": "[KEY]"
}
```
Response:
[![Screen-Shot-2021-09-28-at-11-47-59-PM.png](https://i.postimg.cc/Gh9nHjxc/Screen-Shot-2021-09-28-at-11-47-59-PM.png)](https://postimg.cc/D8VMNLND)

## Tools Used
Unsplash?

| Development | Gems          | Testing       |
|   :----:    |    :----:     |    :----:     |
| Ruby 2.7.2  | Pry           | RSpec         |
| Rails       | SimpleCov     |               |
| VSCode      | Faraday       |               |

## How to Contribute

1. Fork it (<https://github.com/InOmn1aParatus/sweater_weather/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## Personal Info

👤  **Matt Kragen**
- [GitHub](https://github.com/matt-kragen)
- [LinkedIn](https://www.linkedin.com/in/mattkragen/)
