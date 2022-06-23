//
//  ContentView.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var weather: WeatherData
    
    
    var body: some View
    {
        VStack (alignment: .leading,spacing:20.0)
        {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("location    : \(weather.place)")
            Text("temperature : \(weather.current?.temperature.formatted() ?? "--")").foregroundColor(Color.red)
            Text("humidity    : \(weather.current?.humidity.formatted() ?? "--")%")
            Text("pressure    : \(weather.current?.pressure.converted(to: .inchesOfMercury).formatted() ?? "--")")

        }.font(.custom("Courier", fixedSize: 15.0))
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var weatherData = WeatherData()
    
    static var previews: some View
    {
        ContentView(weather: weatherData)
    }
}
