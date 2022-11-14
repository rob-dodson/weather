//
//  WindBlock.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import SwiftUI
import WeatherKit
import Charts

struct DayForecastBlock: View
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
                    
                    Text("Daily Forecast")
                        .foregroundColor(settings.titleColor)
                        .font(.title2)
                }
                
                
                let dailies = weather.dailyForecast
                HStack
                {
                    ForEach(dailies.indices)
                    { index in
                        let day = dailies[index]
                        VStack(spacing: 5.0)
                        {
                            Image(systemName: "\(day.symbolName)")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                                .frame(width: 20.0,height: 20.0,alignment: .bottom)
                            
                            Text("\(day.highTemperature.converted(to: .fahrenheit).formatted())")
                            Text("\(day.lowTemperature.converted(to: .fahrenheit).formatted())")
                            Text("\(day.date.formatted(Date.FormatStyle().weekday()))")
                        }
                    }
                }
                .foregroundColor(settings.tintColor)
                .font(.title3)
                
                let newdailies = convert(oldweatherdata:dailies)
                Chart(newdailies)
                {
                        LineMark(
                                    x: .value("Date", $0.date),
                                    y: .value("Temp", $0.temp)
                                )
                                .foregroundStyle(by: .value("type", $0.type))
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


struct daydata : Identifiable
{
    var date : Date
    var temp : Double
    var type : String
    var id = UUID()
}

func convert(oldweatherdata:Forecast<DayWeather>) -> [daydata]
{
        var newdays = Array<daydata>()
    
        for oldday in oldweatherdata
        {
            let hitemp = oldday.highTemperature.converted(to: .fahrenheit).value
            let lowtemp = oldday.lowTemperature.converted(to: .fahrenheit).value
            
            let hinewday = daydata(date: oldday.date, temp: hitemp, type: "high temp")
            newdays.append(hinewday)
            let lownewday = daydata(date: oldday.date, temp: lowtemp, type: "low temp")
            newdays.append(lownewday)
        }
    
    return newdays
}

