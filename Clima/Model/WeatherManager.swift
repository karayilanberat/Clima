//
//  WeatherManager.swift
//  Clima
//
//  Created by berat on 17.07.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManageDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
        
    let latLonURL = "https://api.openweathermap.org/geo/1.0/direct?q="
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat="
    let APIKey = "037da6165f07bf1fb1c0efbd249a999f"
    
    var delegate: WeatherManageDelegate?
    
    var latitude: Double?
    var longitude: Double?
    
    func fetchAltLon(cityName: String) {
        let urlString = "\(latLonURL)\(cityName)&limit=1&appid=\(APIKey)"
        performRequest(urlString, parseLatLon: true)
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        let urlString = "\(weatherURL)\(lat)&lon=\(lon)&appid=\(APIKey)"

        performRequest(urlString, parseLatLon: false)
    }
    
    func performRequest(_ urlString: String, parseLatLon: Bool) {
        
        // Create a URL
        if let url = URL(string: urlString) {
            
            // Create a URLSession
            let session = URLSession(configuration: .default)
            
            // Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if parseLatLon {
                        self.parseJSONLatLon(JSONData: safeData)
                    } else {
                        if let weather = self.parseJSONWeather(JSONData: safeData) {
                            self.delegate?.didUpdateWeather(weather: weather)
                        }
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSONLatLon(JSONData: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([LatLonData].self, from: JSONData)
            if let firstData = decodedData.first {
                
                let latVal = Double(String(format: "%.2f", firstData.lat)) ?? firstData.lat
                let lonVal = Double(String(format: "%.2f", firstData.lon)) ?? firstData.lon
                
                fetchWeather(lat: latVal , lon: lonVal)
            }
        } catch {
            print(error)
        }
    }
    
    func parseJSONWeather(JSONData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: JSONData)
            
            let weatherID = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: weatherID, cityName: name, temp: temp)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
