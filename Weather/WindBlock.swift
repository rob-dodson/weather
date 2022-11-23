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
    @ObservedObject var settings: Settings

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
                        .foregroundColor(settings.theme.symbolColor)
                    
                    Text("Wind")
                        .foregroundColor(settings.theme.headerColor)
                        .font(settings.headingFont)
                }
                
                Text("\(current.wind.compassDirection.description) @ \(current.wind.speed.formatted())")
                    .font(settings.mainFont)
                
                if let gust = current.wind.gust
                {
                    Text("Gusts \(gust.formatted())")
                        .font(settings.smallFont)
                }
            }
        }
        .padding(.init(settings.blockPadding))
        .foregroundColor(settings.theme.textColor)
        .background(settings.theme.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

