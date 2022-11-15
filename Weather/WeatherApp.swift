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
    
    var body: some Scene
    {
        MenuBarExtra("Weather", systemImage: "cloud.sun.fill")
        {
            ScrollView
            {
                 ContentView(myweather: myweather).environmentObject(Settings())
            }
            .frame(width: 500,height: 600,alignment: .center)
            .scenePadding(.all)
            
            
        }
        .menuBarExtraStyle(.window)
        
    }
}
