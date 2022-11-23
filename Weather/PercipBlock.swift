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
    @ObservedObject var settings: Settings

    
    var body: some View
    {
        VStack(alignment: .center, spacing: 1.0)
        {
            if let _ = myweather.theweather?.currentWeather
            {
                let daily = myweather.theweather?.dailyForecast[0]
                
                
                HStack(spacing:10.0)
                {
                    Image(systemName: "cloud.rain")
                        .imageScale(.medium)
                        .foregroundColor(settings.theme.symbolColor)
                    Text("Precipitation")
                        .foregroundColor(settings.theme.headerColor)
                        .font(settings.headingFont)
                }
                
                
                let preciptype = daily!.precipitation
                if preciptype != .none
                {
                    let chance = Int(daily!.precipitationChance * 100)
                    
                    Text("Chance of \(daily!.precipitation.description )")
                    Text("\(chance)%")
                }
                else
                {
                    Text("None")
                }
                    
            }
        }
        .padding(.init(settings.blockPadding))
        .font(settings.mainFont)
        .foregroundColor(settings.theme.textColor)
        .background(settings.theme.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

