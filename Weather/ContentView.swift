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
            TemperatureBlock(myweather: myweather)
            
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
            
            DayForecastBlock(myweather: myweather)
            HourForecastBlock(myweather: myweather)
        }
    }
    
}


