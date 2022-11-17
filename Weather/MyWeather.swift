//
//  WeatherData.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import Foundation
import WeatherKit
import MapKit
import CoreLocation


@MainActor
class MyWeather: ObservableObject
{
    static let shared = MyWeather()
    
    let location = Location()
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
                    print("weather loaded")
                    theweather = weather
                }
                
                try await Task.sleep(for:.seconds(60 * 15))
            }
        }
    }
    
    
    func lookUpWeather(for address: String?) async -> Weather?
    {
        if address == nil
        {
            var gotloc = false
            
            do
            {
                while (gotloc == false)
                {
                    if location.haveLocation() == true
                    {
                        gotloc = true
                    }
                    else
                    {
                        try await Task.sleep(for:.seconds(3))
                    }
                }
                
                let locations = location.getLocations()
                if locations.count > 0
                {
                    let geocoder = CLGeocoder()
                    let placemark = try await geocoder.reverseGeocodeLocation(locations[0])
                    place = "\(placemark[0].locality ?? "?") \(placemark[0].administrativeArea ?? "?")"
                    
                    let weather = try await WeatherService.shared.weather(for:locations[0])
                    return weather
                }
            }
            catch
            {
                print("cllocation error: \(error)")
            }
        }
        else
        {
            
            let geocoder = CLGeocoder()
            
            do
            {
                let placemark = try await geocoder.geocodeAddressString(address ?? "Tacoma WA")
                
                if let location = placemark[0].location
                {
                    let weather = try await WeatherService.shared.weather(for:location)
                    return weather
                }
                else
                {
                    print("Failed getting location for \(String(describing: address))")
                    return nil
                }
            }
            catch
            {
                print("geocode error: \(error)")
                return nil
            }
        }
        return nil
    }
    
    
}
        
    

