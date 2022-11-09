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
    @EnvironmentObject var settings: Settings

    
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
                    Image(systemName: "moon")
                        .imageScale(.medium)
                    Text("Sun & Moon")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                .foregroundColor(settings.tintColor)
                
                if let sun = daily?.sun
                {
                    VStack
                    {
                        HStack
                        {
                            Text("Sun")
                            Image(systemName: "arrow.up")
                                .imageScale(.small)
                            Text("\((sun.sunrise?.formatted(date: .omitted, time: .shortened) )!)")
                            
                            Image(systemName: "arrow.down")
                                .imageScale(.small)
                            
                            Text("\((sun.sunset?.formatted(date: .omitted, time: .shortened))!)")
                            
                            Text("UV: \(current.uvIndex.category.rawValue)")
                                .font(.system(size: 10.0))
                        }
                        .foregroundColor(settings.tintColor)
                        .font(.title3)
                        
                        if let moon = daily?.moon
                        {
                            HStack
                            {
                                Text("Moon")
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                
                                Text("\((moon.moonrise?.formatted(date: .omitted, time: .shortened) )!)")
                                
                                Image(systemName: "arrow.down")
                                    .imageScale(.small)
                                Text("\((moon.moonset?.formatted(date: .omitted, time: .shortened))!)")
                                
                                Text("Phase: \(moon.phase.rawValue)")
                                    .font(.system(size: 10.0))
                                
                                Image(systemName: moon.phase.symbolName)
                                    .imageScale(.small)
                            }
                            .foregroundColor(settings.tintColor)
                            .font(.title3)
                        }
                    }
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
