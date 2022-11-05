//
//  WeatherData.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import Foundation
import WeatherKit
import MapKit

@MainActor
class WeatherData: ObservableObject
{
    static let shared = WeatherData()
    private let service = WeatherService.shared
    
    @Published var current : CurrentWeather?
    @Published var place = "Home"
    
    init()
    {
        getWeather()
    }
    
    
   func getWeather()
    {
        Task
        {
            do
            {
                place = "Tacoma Washington USA"
                if let forecast = await WeatherData.shared.weather(for:place)
                {
                    current = forecast
                    
                    print("=====")
                    print(" location     : \(place)")
                    print(" temp         : \(forecast.temperature.converted(to: .fahrenheit).formatted())")
                    print(" feels like   : \(forecast.apparentTemperature.converted(to: .fahrenheit).formatted())")
                    print(" cloudcover   : \(forecast.cloudCover)%")
                    print(" condition    : \(forecast.condition)")
                    print(" humidity     : \(forecast.humidity)%")
                    print(" pressure     : \(forecast.pressure.converted(to: .inchesOfMercury).formatted())")
                    print(" pressureTrend: \(forecast.pressureTrend)")
                    print(" symbol       : \(forecast.symbolName)")
                    print(" wind dir     : \(forecast.wind.compassDirection) \(forecast.wind.direction)")
                    print(" wind speed   : \(forecast.wind.speed.formatted())")
                    if let gust = forecast.wind.gust
                    {
                        print(" wind gust    : \(gust.formatted())")
                    }
                    print(" uvIndex      : \(forecast.uvIndex.category)")
                    print(" visibility   : \(forecast.visibility.converted(to: .miles).formatted())")
                    print(" dewPoint     : \(forecast.dewPoint.converted(to: .fahrenheit).formatted())")
                }
                
                try await Task.sleep(nanoseconds: 500000000000)
            }
        }
    }
    
    func weather(for address: String) async -> CurrentWeather?
    {
        let geocoder = CLGeocoder()
        
        do
        {
            let placemark = try await geocoder.geocodeAddressString(address)
            
            
            print("Placemark: \(placemark[0])")
            if let location = placemark[0].location
            {
                let forecast = try await self.service.weather(for:location ,including: .current)
                return forecast
            }
            else
            {
                return nil
            }
        }
        catch
        {
            print("geocode error: \(error)")
            return nil
        }
    }
}
        
    

