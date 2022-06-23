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
                place = "Tacoma WA"
                if let forcast = await WeatherData.shared.weather(for:place)
                {
                    current = forcast
                    
                    print("=====")
                    print(" location     : \(place)")
                    print(" temp         : \(forcast.temperature.converted(to: .fahrenheit).formatted())")
                    print(" feels like   : \(forcast.apparentTemperature.converted(to: .fahrenheit).formatted())")
                    print(" cloudcover   : \(forcast.cloudCover)%")
                    print(" condition    : \(forcast.condition)")
                    print(" humidity     : \(forcast.humidity)%")
                    print(" pressure     : \(forcast.pressure.converted(to: .inchesOfMercury).formatted())")
                    print(" pressureTrend: \(forcast.pressureTrend)")
                    print(" symbol       : \(forcast.symbolName)")
                    print(" wind dir     : \(forcast.wind.compassDirection) \(forcast.wind.direction)")
                    print(" wind speed   : \(forcast.wind.speed.formatted())")
                    if let gust = forcast.wind.gust
                    {
                        print(" wind gust    : \(gust.formatted())")
                    }
                    print(" uvIndex      : \(forcast.uvIndex.category)")
                    print(" visibility   : \(forcast.visibility.converted(to: .miles).formatted())")
                    print(" dewPoint     : \(forcast.dewPoint.converted(to: .fahrenheit).formatted())")
                }
                
                try await Task.sleep(nanoseconds: 5000000000)
            }
        }
    }
    
    func weather(for address: String) async -> CurrentWeather?
    {
        let geocoder = CLGeocoder()
        
        do
        {
            let placemark = try await geocoder.geocodeAddressString(address)
            
            if let location = placemark[0].location
            {
                let forcast = try await self.service.weather(for:location ,including: .current)
                return forcast
            }
            else
            {
                return nil
            }
        }
        catch
        {
            return nil
        }
    }
}
        
    

