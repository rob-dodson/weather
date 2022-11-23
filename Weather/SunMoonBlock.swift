//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct SunMoonBlock: View
{
    @ObservedObject var myweather: MyWeather
    @ObservedObject var settings: Settings

    
    var body: some View
    {
        VStack(alignment: .center, spacing: 5.0)
        {
            if let current = myweather.theweather?.currentWeather
            {
                let daily = myweather.theweather?.dailyForecast[0]
                
                HStack(spacing:10.0)
                {
                    Image(systemName: "sun.max")
                        .imageScale(.medium)
                        .foregroundColor(settings.theme.symbolColor)
                    Image(systemName: "moon")
                        .imageScale(.medium)
                        .foregroundColor(settings.theme.symbolColor)
                    Text("Sun & Moon")
                        .foregroundColor(settings.theme.headerColor)
                        .font(settings.headingFont)
                }
                .foregroundColor(settings.theme.textColor)
                
                if let sun = daily?.sun
                {
                    VStack
                    {
                        HStack
                        {
                            Text("Sun")
                            
                            HStack(spacing: 1.0)
                            {
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                    .foregroundColor(settings.theme.symbolColor)
                                
                                if let sunrise = sun.sunrise
                                {
                                    Text("\((sunrise.formatted(date: .omitted, time: .shortened)))")
                                }
                                else { Text("---") }
                            }
                            
                            HStack(spacing: 1.0)
                            {
                                Image(systemName: "arrow.down")
                                    .imageScale(.small)
                                    .foregroundColor(settings.theme.symbolColor)
                                
                                if let sunset = sun.sunset
                                {
                                    Text("\((sunset.formatted(date: .omitted, time: .shortened)))")
                                }
                                else { Text("---") }
                            }
                            
                            Text("UV: \(current.uvIndex.category.description)")
                                .font(settings.smallFont)
                        }
                        .foregroundColor(settings.theme.textColor)
                        .font(settings.mainFont)
                        
                        if let moon = daily?.moon
                        {
                            HStack()
                            {
                                Text("Moon")
                                
                                HStack(spacing: 1.0)
                                {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .foregroundColor(settings.theme.symbolColor)
                                    
                                    if let moonrise = moon.moonrise
                                    {
                                        Text("\((moonrise.formatted(date: .omitted, time: .shortened)))")
                                    }
                                    else { Text("---") }
                                }
                                
                                HStack(spacing: 1.0)
                                {
                                    Image(systemName: "arrow.down")
                                        .imageScale(.small)
                                        .foregroundColor(settings.theme.symbolColor)
                                    
                                    if let moonset = moon.moonset
                                    {
                                        Text("\((moonset.formatted(date: .omitted, time: .shortened)))")
                                    }
                                    else { Text("---") }
                                }
                                
                                Text("Phase: \(moon.phase.description)")
                                    .font(settings.smallFont)
                                
                                Image(systemName: moon.phase.symbolName)
                                    .imageScale(.small)
                                    .foregroundColor(settings.theme.symbolColor)
                            }
                            .foregroundColor(settings.theme.textColor)
                            .font(settings.mainFont)
                        }
                    }
                }
            }
        }
        .padding(.init(settings.blockPadding))
        .background(settings.theme.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

