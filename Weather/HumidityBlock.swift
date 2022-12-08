//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct HumidityBlock: View
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
                    Image(systemName: "humidity")
                        .imageScale(.medium)
                        .foregroundColor(settings.theme.symbolColor)
                    
                    Text("Humidity")
                        .font(.title2)
                        .foregroundColor(settings.theme.headerColor)
                }
                .foregroundColor(settings.theme.textColor)
                
                HStack
                {
                    let humidstr = NSString(format:"%.0f", current.humidity * 100)

                    Text("humidity: \(humidstr)%")
                    Text("dew point:  \(current.dewPoint.converted(to: .fahrenheit).formatted())")
                    Text("visibility: \(current.visibility.converted(to: .miles).formatted())")
                }
                .foregroundColor(settings.theme.textColor)
                .font(.title3)
                        
            }
        }
        .padding(.init(settings.blockPadding))
        .background(settings.theme.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

