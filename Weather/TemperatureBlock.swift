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
                        .foregroundColor(settings.tintColor)
                    
                    Text("\(myweather.place)")
                        .foregroundColor(settings.titleColor)
                        .font(.system(size: 50.0))
                }
                
                Text("\(current.temperature.formatted())")
                    .foregroundColor(settings.tintColor)
                    .font(.system(size: 40.0))
                
                Text("Feels Like \(current.apparentTemperature.formatted())")
                    .foregroundColor(settings.tintColor)
                    .font(.title3)
                
                if let daily = myweather.theweather?.dailyForecast[0]
                {
                    HStack(spacing:15.0)
                    {
                        Text("Low \(daily.lowTemperature.formatted())")
                            .foregroundColor(settings.tintColor)
                            .font(.title3)
                        Text("High \(daily.highTemperature.formatted())")
                            .foregroundColor(settings.tintColor)
                            .font(.title3)
                    }
                    Text("\(current.condition.description)")
                        .foregroundColor(settings.tintColor)
                        .font(.title3)
                }
            }
        }
        .padding()
        .background(settings.blockColor)
        .cornerRadius(15)
        .shadow(radius: 10)
        .opacity(60.0)
    }
}

