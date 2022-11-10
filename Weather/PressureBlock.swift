//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit

struct PressureBlock: View
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
                    Image(systemName: "gauge.medium")
                        .imageScale(.medium)
                    Text("Pressure")
                        .font(.title2)
                        .foregroundColor(settings.titleColor)
                }
                .foregroundColor(settings.tintColor)
                
                HStack
                {
                    let hg = current.pressure.converted(to:.inchesOfMercury).value
                    let hgstr = NSString(format:"%.2f",hg)
                    Text("\(hgstr)")
                    
                    switch current.pressureTrend
                    {
                    case .falling:
                        Image(systemName:"arrow.down.right")
                            .imageScale(.medium)
                    case .rising:
                        Image(systemName:"arrow.up.right")
                            .imageScale(.medium)
                    case .steady:
                        Image(systemName:"arrow.right")
                            .imageScale(.medium)
                    default:
                        Image(systemName:"questionmark")
                            .imageScale(.medium)
                    }
                    
                    Text("\(current.pressureTrend.rawValue)")
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

