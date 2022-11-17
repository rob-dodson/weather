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
                        .foregroundColor(settings.symbolColor)
                    
                    Text("Pressure")
                        .font(settings.headingFont)
                        .foregroundColor(settings.titleColor)
                }
                .foregroundColor(settings.tintColor)
                
                HStack
                {
                    let hg = current.pressure.converted(to:.inchesOfMercury).value
                    let hgstr = NSString(format:"%.2f",hg)
                    Text("\(hgstr)")
                    
                    HStack(spacing: 1.0)
                    {
                        switch current.pressureTrend
                        {
                        case .falling:
                            Image(systemName:"arrow.down.right")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                        case .rising:
                            Image(systemName:"arrow.up.right")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                        case .steady:
                            Image(systemName:"arrow.right")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                        default:
                            Image(systemName:"questionmark")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                        }
                        
                        Text("\(current.pressureTrend.description)")
                    }
                }
                .foregroundColor(settings.tintColor)
                .font(settings.mainFont)
                        
            }
        }
        .padding(.init(settings.blockPadding))
        .background(settings.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

