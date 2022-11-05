//
//  WeatherApp.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

@main
struct WeatherApp: App
{
    @StateObject private var weatherData = MyWeather.shared

    var body: some Scene
    {
        WindowGroup
        {
            ContentView(weather: weatherData)
        }
    }
}
