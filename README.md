# Clima - Weather App

## Overview

Clima is a beautiful, dark-mode enabled weather app that allows users to check the current weather for their location or search for a city's weather manually. The app leverages the power of Core Location to get the user's current GPS location and fetches live weather data from the OpenWeatherMap API.

## Features

- Dark Mode Support
- Location-Based Weather
- City Search
- Vector Images for Scalable Graphics
- UITextField for User Input
- Delegate Pattern for Code Organization
- Swift Protocols and Extensions
- URLSession for Networking
- JSON Parsing with Decodable Protocol
- Core Location for GPS-based Location Services
- Error Handling

## Installation

```bash
git clone https://github.com/yourusername/Clima.git
cd Clima
open Clima.xcodeprojü

## Usage

- Build and run the app on an iOS simulator or a physical device.
- Allow location permissions to fetch the current weather.
- Enter a city name in the search bar to fetch and display the weather for that location.

## Project Structure

-Model
-WeatherModel.swift
-LatLonData.swift
-WeatherData.swift
-View
-Main.storyboard
-Controller
-WeatherViewController.swift
-WeatherManager.swift
