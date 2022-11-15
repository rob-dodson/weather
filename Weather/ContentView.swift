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
        VStack (alignment:.center,spacing:10.0)
        {
            Text("Weather")
                .foregroundColor(settings.topTitleColor)
                .font(.title)
            
            Rectangle()
                .stroke(settings.tintColor)
                .frame(width: 500, height: 1)
            
            TemperatureBlock(myweather: myweather)
            DayForecastBlock(myweather: myweather)
            
            HStack()
            {
                WindBlock(myweather: myweather)
                PrecipBlock(myweather: myweather)
            }
            
            HStack
            {
                SunMoonBlock(myweather: myweather)
                PressureBlock(myweather: myweather)
            }
            
            HStack
            {
                HumidityBlock(myweather: myweather)
            }
            
            HourForecastBlock(myweather: myweather)
        }
    }
    
}


