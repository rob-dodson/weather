//
//  ContentView.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings

    
    var body: some View
    {
        VStack (alignment:.center,spacing:15.0)
        {
            Text("Weather")
                .foregroundColor(settings.topTitleColor)
                .font(settings.hugeFont)
            
            Rectangle()
                .stroke(Color.black)
                .frame(width: 500, height: 1)
            
            TemperatureBlock(myweather: myweather)
            DayForecastBlock(myweather: myweather)
            HourForecastBlock(myweather: myweather)
        }
    }
    
}


