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
                HStack(spacing: 15)
                {
                    ForEach(dailies.indices)
                    { index in
                        let day = dailies[index]
                        VStack(spacing: 5.0)
                        {
                            Image(systemName: "\(day.symbolName)")
                                .imageScale(.medium)
                                .foregroundColor(settings.symbolColor)
                                .frame(width: 20.0,height: 20.0,alignment: .center)
                            
                           // Text("\(day.highTemperature.converted(to: .fahrenheit).formatted())")
                          // Text("\(day.lowTemperature.converted(to: .fahrenheit).formatted())")
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
                            y: .value("Val", $0.val)
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
    var val : Double
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
            
            let a = daydata(date: oldday.date, val: hitemp,type:"High Temp")
            newdays.append(a)
            let b = daydata(date: oldday.date, val: lowtemp,type:"Low Temp")
            newdays.append(b)
            let c = daydata(date: oldday.date, val: oldday.precipitationChance * 100.0,type:"Precip Chance")
            newdays.append(c)
            let d = daydata(date: oldday.date, val: oldday.wind.speed.value,type:"Wind")
            newdays.append(d)

        }
    
    return newdays
}

