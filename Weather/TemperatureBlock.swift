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
        VStack(alignment: .center, spacing: 1.0)
        {
            if let current = myweather.theweather?.currentWeather
            {
                HStack(spacing:10.0)
                {
                    Image(systemName: current.symbolName)
                        .imageScale(.large)
                        .foregroundColor(settings.theme.symbolColor)
                    
                    Text("\(myweather.place)")
                        .font(settings.titleFont)
                        .foregroundColor(settings.theme.headerColor)
                }
                
                Text("\(current.date.formatted())")
                    .font(settings.smallFont)
                
                Text("\(current.temperature.formatted(.measurement(width: .abbreviated)))")
                    .font(settings.titleFont)
                
                Text("Feels Like \(current.apparentTemperature.formatted(.measurement(width: .abbreviated)))")
                
                if let daily = myweather.theweather?.dailyForecast[0]
                {
                    HStack(spacing:12.0)
                    {
                        Text("Low \(daily.lowTemperature.formatted(.measurement(width: .abbreviated)))")
                        Text("High \(daily.highTemperature.formatted(.measurement(width: .abbreviated)))")
                    }
                    Text("\(current.condition.description)")
                }
            }

            VStack(alignment: .center, spacing: 5.0)
            {
                PrecipBlock(myweather: myweather)
                PressureBlock(myweather: myweather)
                WindBlock(myweather: myweather)
                SunMoonBlock(myweather: myweather)
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

