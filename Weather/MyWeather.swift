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
class MyWeather: ObservableObject
{
    static let shared = MyWeather()
    
    @Published var theweather : Weather?
    @Published var place = "Home"
    
    init()
    {
        getWeather()
    }
    
    
   func getWeather()
    {
        Task
        {
            while(true)
            {
                place = "Tacoma WA"
                if let weather = await MyWeather.shared.lookUpWeather(for:place)
                {
                    theweather = weather
                    
                    if let current = theweather?.currentWeather
                    {
                        print("=====")
                        print(" location     : \(place)")
                        print(" temp         : \(current.temperature.converted(to: .fahrenheit).formatted())")
                        print(" feels like   : \(current.apparentTemperature.converted(to: .fahrenheit).formatted())")
                        print(" cloudcover   : \(current.cloudCover)%")
                        print(" condition    : \(current.condition)")
                        print(" humidity     : \(current.humidity)%")
                        print(" pressure     : \(current.pressure.converted(to: .inchesOfMercury).formatted())")
                        print(" pressureTrend: \(current.pressureTrend)")
                        print(" symbol       : \(current.symbolName)")
                        print(" wind dir     : \(current.wind.compassDirection) \(current.wind.direction)")
                        print(" wind speed   : \(current.wind.speed.formatted())")
                        if let gust = current.wind.gust
                        {
                            print(" wind gust    : \(gust.formatted())")
                        }
                        print(" uvIndex      : \(current.uvIndex.category)")
                        print(" visibility   : \(current.visibility.converted(to: .miles).formatted())")
                        print(" dewPoint     : \(current.dewPoint.converted(to: .fahrenheit).formatted())")
                    }
                    
                    if let daily = theweather?.dailyForecast[0]
                    {
                        print(" low           : \(daily.lowTemperature.converted(to: .fahrenheit).formatted())")
                        print(" high          : \(daily.highTemperature.converted(to: .fahrenheit).formatted())")
                        print(" precip chance : \(daily.precipitationChance * 100)% chance of \(daily.precipitation.description)")
                    }
                }
                
                try await Task.sleep(for:.seconds(60 * 5))
            }
        }
    }
    
    
    func lookUpWeather(for address: String) async -> Weather?
    {
        let geocoder = CLGeocoder()
        
        do
        {
            let placemark = try await geocoder.geocodeAddressString(address)
            
            if let location = placemark[0].location
            {
                let weather = try await WeatherService.shared.weather(for:location)
                return weather
            }
            else
            {
                print("Failed getting location \(address)")
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
        
    

