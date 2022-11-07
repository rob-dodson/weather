//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct PrecipBlock: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings

    
    var body: some View
    {
        VStack(alignment: .center, spacing: 5.0)
        {
            if let current = myweather.theweather?.currentWeather
            {
                let daily = myweather.theweather?.dailyForecast[0]
                let chance = Int(daily!.precipitationChance * 100)
                
                HStack(spacing:10.0)
                {
                    Image(systemName: "cloud.rain")
                        .imageScale(.medium)
                        .foregroundColor(settings.tintColor)
                    
                    Text("Precipitation")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                
                   
                    
                Text("Chance of \(daily!.precipitation.description)")
                    .foregroundColor(settings.tintColor)
                    .font(.title3)
                Text("\(chance)%")
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

