//
//  ContentView.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var weather: MyWeather
    
    
    var body: some View
    {
        VStack (alignment: .leading,spacing:20.0)
        {
            if let current = weather.theweather?.currentWeather
            {
                Image(systemName: current.symbolName)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                
                Text("location    : \(weather.place)")
                Text("temperature : \(current.temperature.formatted())").foregroundColor(Color.red)
                Text("feels like  : \(current.apparentTemperature.formatted())").foregroundColor(Color.blue)
                Text("condition   : \(current.condition.description)")
                Text("humidity    : \(current.humidity.formatted())%")
                Text("pressure    : \(current.pressure.converted(to: .inchesOfMercury).formatted())")
                Text("wind        : \(current.wind.compassDirection.description) @ \(current.wind.speed.formatted())")
            }
            
            if let daily = weather.theweather?.dailyForecast[0] // what is at [0]?
            {
                Text("low temp    : \(daily.lowTemperature.formatted())")
                Text("high temp   : \(daily.highTemperature.formatted())")
                Text("precip      : \(daily.precipitationChance * 100)% chance of \(daily.precipitation.description)")
            }
            
        }.font(.custom("Courier", fixedSize: 15.0))
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var weatherData = MyWeather()
    
    static var previews: some View
    {
        ContentView(weather: weatherData)
    }
}
