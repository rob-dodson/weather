//
//  TempBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit



struct TemperatureBlock: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 5.0)
        {
            if let current = myweather.theweather?.currentWeather
            {
               
                
                HStack(spacing:10.0)
                {
                    Image(systemName: current.symbolName)
                        .imageScale(.large)
                    
                    Text("\(myweather.place)")
                        .font(.system(size: 50.0))
                        .foregroundColor(settings.titleColor)
                }
                
                Text("\(current.temperature.formatted())")
                    .font(.system(size: 40.0))
                
                Text("Feels Like \(current.apparentTemperature.formatted())")
                
                if let daily = myweather.theweather?.dailyForecast[0]
                {
                    HStack(spacing:15.0)
                    {
                        Text("Low \(daily.lowTemperature.formatted())")
                        Text("High \(daily.highTemperature.formatted())")
                    }
                    Text("\(current.condition.description)")
                }
            }
        }
        .padding()
        .font(.title3)
        .foregroundColor(settings.tintColor)
        .background(settings.blockColor)
        .cornerRadius(15)
        .shadow(radius: 10)
        .opacity(60.0)
    }
}
