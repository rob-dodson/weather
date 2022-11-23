//
//  WeatherApp.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

/*
@main
struct WeatherApp: App
{
    @StateObject private var myweather : MyWeather = MyWeather.shared

    var body: some Scene
    {
        WindowGroup
        {
            ContentView(myweather: myweather).environmentObject(Settings())
        }
    }
}
*/

@main
struct WeatherApp: App
{
    @StateObject private var myweather : MyWeather = MyWeather.shared
    @ObservedObject var settings = Settings()
    
    var body: some Scene
    {
        MenuBarExtra("Weather", systemImage: "cloud.sun.fill")
        {
            ContentView(myweather: myweather,settings: Settings())
        }
        .menuBarExtraStyle(.window)
        
            
    }
    
    
    
}
