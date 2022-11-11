//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct DayForecastBlock: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings

    
    var body: some View
    {
        VStack(alignment: .center, spacing: 5.0)
        {
            if let weather = myweather.theweather
            {
                Text("Daily Forecast")
                    .foregroundColor(settings.titleColor)
                    .font(.title2)
                
                let dailies = weather.dailyForecast
                HStack
                {
                    ForEach(dailies.indices)
                    { index in
                        let day = dailies[index]
                        VStack
                        {
                            Image(systemName: "\(day.symbolName)")
                                .imageScale(.medium)
                            
                            Text("\(day.highTemperature.converted(to: .fahrenheit).formatted())")
                            Text("\(day.lowTemperature.converted(to: .fahrenheit).formatted())")
                            Text("\(day.date.formatted(Date.FormatStyle().weekday()))")
                        }
                    }
                }
                .foregroundColor(settings.tintColor)
                .font(.title3)
            }
        }
        .padding()
        .background(settings.blockColor)
        
        .cornerRadius(15)
        .shadow(radius: 10)
        .opacity(60.0)
    }
}

