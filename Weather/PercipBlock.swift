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
            if let _ = myweather.theweather?.currentWeather
            {
                let daily = myweather.theweather?.dailyForecast[0]
                
                
                HStack(spacing:10.0)
                {
                    Image(systemName: "cloud.rain")
                        .imageScale(.medium)
                    
                    Text("Precipitation")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                
                
                let preciptype = daily!.precipitation
                if preciptype != .none
                {
                    let chance = Int(daily!.precipitationChance * 100)
                    
                    Text("Chance of \(daily!.precipitation.rawValue )")
                    Text("\(chance)%")
                }
                else
                {
                    Text("None")
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

