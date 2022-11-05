//
//  WeatherData.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import Foundation
import WeatherKit
import MapKit


struct TheWeather
{
    let currentweather: CurrentWeather
}


@MainActor
class MyWeather: ObservableObject
{
    static let shared = MyWeather()
    
    private let service = WeatherService.shared
    
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
            do
            {
                place = "Tacoma Washington USA"
                if let weather = await MyWeather.shared.weather(for:place)
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
                        print(" precip chance : \(daily.precipitationChance * 100)% chance of \(daily.precipitation)")
                    }
                }
                
                try await Task.sleep(nanoseconds: 5000000000)
            }
        }
    }
    
    func weather(for address: String) async -> Weather?
    {
        let geocoder = CLGeocoder()
        
        do
        {
            let placemark = try await geocoder.geocodeAddressString(address)
            
            
            print("Placemark: \(placemark[0])")
            if let location = placemark[0].location
            {
                let weather = try await self.service.weather(for:location)
                return weather
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
        
    

