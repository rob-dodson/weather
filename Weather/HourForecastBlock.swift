//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit
import Charts


struct HourForecastBlock: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings

    
    var body: some View
    {
        VStack(alignment: .center, spacing: 10.0)
        {
            if let weather = myweather.theweather
            {
                HStack
                {
                    Image(systemName: "chart.xyaxis.line")
                        .imageScale(.medium)
                        .foregroundColor(settings.symbolColor)
                        .frame(width: 20.0,height: 20.0,alignment: .bottom)
                    
                    Text("Hourly Forecast")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                
                
                let hours = weather.hourlyForecast
                HStack
                {
                    ForEach(hours.indices)
                    { index in
                        let hour = hours[index]
                        if hour.date.timeIntervalSinceNow > 0 && hour.date.timeIntervalSinceNow < (60 * 60 * 12)
                        {
                            VStack(spacing: 5.0)
                            {
                                Image(systemName: "\(hour.symbolName)")
                                    .imageScale(.medium)
                                    .foregroundColor(settings.symbolColor)
                                
                                Text("\(hour.temperature.converted(to: .fahrenheit).formatted())")
                                Text("\(hour.date.formatted(Date.FormatStyle().hour()))")
                                Text("\(hour.date.formatted(Date.FormatStyle().weekday()))")
                            }
                        }
                    }
                }
                .foregroundColor(settings.tintColor)
                .font(.title3)
                
                let newhours = convert(oldweatherdata:hours)
                Chart(newhours)
                {
                        LineMark(
                                    x: .value("Date", $0.date),
                                    y: .value("Temp", $0.temp)
                                )
                                .foregroundStyle(.blue)
                }
                .frame(width:400,height:100)
                
            }
        }
        .padding()
        .background(settings.blockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
}

struct hourdata : Identifiable
{
    var date : Date
    var temp : Double
    var id = UUID()
}

func convert(oldweatherdata:Forecast<HourWeather>) -> [hourdata]
{
        var newhours = Array<hourdata>()
    
        for oldhour in oldweatherdata
        {
            if oldhour.date.timeIntervalSinceNow > 0 && oldhour.date.timeIntervalSinceNow < (60 * 60 * 12)
            {
                let newhour = hourdata(date: oldhour.date,
                                       temp: oldhour.temperature.converted(to: .fahrenheit).value)
                newhours.append(newhour)
            }
        }
    
    return newhours
}
