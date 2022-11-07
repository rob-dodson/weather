//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct WindBlock: View
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
                    Image(systemName: "wind")
                        .imageScale(.medium)
                        .foregroundColor(settings.tintColor)
                    
                    Text("Wind")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                
                Text("\(current.wind.compassDirection.description) @ \(current.wind.speed.formatted())")
                    .foregroundColor(settings.tintColor)
                    .font(.title3)
                
                if let gust = current.wind.gust
               {
                    Text("Gusts \(gust.formatted())")
                        .foregroundColor(settings.tintColor)
                        .font(.system(size: 10.0))
                }
            }
        }
        .padding()
        .background(settings.blockColor)
        .cornerRadius(15)
        .shadow(radius:10)
        .opacity(60.0)
    }
}

