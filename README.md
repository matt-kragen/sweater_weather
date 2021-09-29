# Sweater Weather

> Sweater Weather was a 7-day solo project for Turing School's Back End Engineering Program

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

*Sweater Weather* is a Rails API that provides the information necessary to build a front-end application. It uses its access to MapQuest routing features and OpenWeather forecasts to provide a user with details about a potential road trip.

## Learning Goals

This project was intended as an exercise to practice:
- Exposing API endpoints
- Aggregating and exposing data from external APIs
- API-based CRUD functionality
- API key generation; token-based authentication
- Building endpoints based on front-end wireframes
- Data manipulation; complex method implementation

## Features

Upon registration with an email address, users are provided with a unique API key. This key can then be used to access the Road Trip endpoint. By combining MapQuest's Route service with OpenWeather's Onecall service, this application can display the travel time to a user's chosen destination along with the predicted weather forecast at their time/date of arrival.

In addition, this app allows for:
- Keyword-based forecast searches by location using OpenWeather's Onecall service
- Keyword-based background image searches using Pexels's Image service
- Session creation with user authentication
- API-key authentication
- Custom error-handling messages to control for sad paths/edge cases

## API Endpoints

| Feature                        | Endpoint                                       |
|--------------------------------|------------------------------------------------|
| Retrieve forecast for location | `GET  /api/v1/forecast?location={location}`    |
| Retrieve background image      | `GET  /api/v1/backgrounds?location={location}` |
| Create User                    | `POST /api/v1/users` (JSON body required)      |
| Login User                     | `POST /api/v1/sessions` (JSON body required)   |
| Create new Road Trip           | `POST /api/v1/road_trip` (JSON body required)  |

## Usage Examples

### Location-based Weather Forecast
Endpoint: `GET  /api/v1/forecast?location=sandiego`

[![Screen-Shot-2021-09-29-at-12-12-23-AM.png](https://i.postimg.cc/cHvDPzFv/Screen-Shot-2021-09-29-at-12-12-23-AM.png)](https://postimg.cc/zb1SgxZN)


### New Road Trip with travel time and predictive weather forecast
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

| Development   | Gems                | Testing          |
|---------------|---------------------|------------------|
| Ruby on Rails | Faraday             | RSpec            |
| VSCode        | Pry                 | Postman          |
| Git           | SimpleCov           | Shoulda-Matchers |
| GitHub        | Factory Bot (Rails) | VCR              |
|               | Rubocop (Rails)     | Webmock          |
|               | Figaro              |                  |
|               | FastJSON API        |                  |
|               | BCrypt              |                  |


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
