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
    @ObservedObject var settings: Settings

    
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
                        .foregroundColor(settings.theme.symbolColor)
                    
                    Text("Ten Day Forecast")
                        .foregroundColor(settings.theme.headerColor)
                        .font(settings.headingFont)
                }
                
                let dailies = weather.dailyForecast
                HStack(spacing: 12)
                {
                    ForEach(dailies.indices)
                    { index in
                        let day = dailies[index]
                        VStack(spacing: 5.0)
                        {
                            Image(systemName: "\(day.symbolName)")
                                .imageScale(.medium)
                                .foregroundColor(settings.theme.symbolColor)
                                .frame(width: 20.0,height: 20.0,alignment: .center)
                            
                            if day.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted)
                            {
                                //Text("\(day.date.formatted(Date.FormatStyle().weekday()))")
                                Text("Today")
                            }
                            else
                            {
                                Text("\(day.date.formatted(Date.FormatStyle().weekday()))")
                            }
                        }
                    }
                }
                .foregroundColor(settings.theme.textColor)
                .font(settings.mainFont)
                
                let newdailies = convert(oldweatherdata:dailies)
                Chart(newdailies)
                {
                        LineMark(
                            x: .value("Date", $0.date),
                            y: .value("Val", $0.val)
                        )
                        .foregroundStyle(by: .value("type", $0.type) )
                        .interpolationMethod(.cardinal)
                }
                .chartYAxis
                {
                    AxisMarks(values: .automatic)
                    { _ in
                        AxisGridLine(stroke: .init(lineWidth: 0.5,dash:[2.5,2.5])).foregroundStyle(settings.theme.textColor)
                        AxisValueLabel().foregroundStyle(settings.theme.textColor)//.offset(x: 10).font(.subheadline)
                    }
                }
                .chartXAxis
                {
                    AxisMarks(values: .automatic)
                    { _ in
                        AxisGridLine(stroke: .init(lineWidth: 0.5,dash:[2.5,2.5])).foregroundStyle(settings.theme.textColor)
                        AxisValueLabel().foregroundStyle(settings.theme.textColor)
                    }
                }
                .frame(width:420,height:100)
                .chartForegroundStyleScale([
                    "High Temp" : settings.theme.hitempColor,
                    "Low Temp" : settings.theme.lowtempColor,
                    "Wind" : settings.theme.windColor,
                    "Precip Chance" : settings.theme.precipColor
                ])
            }
        }
        .padding()
        .background(settings.theme.blockColor)
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
            let d = daydata(date: oldday.date, val: oldday.wind.speed.value,type:"Wind")
            newdays.append(d)
            let c = daydata(date: oldday.date, val: oldday.precipitationChance * 100.0,type:"Precip Chance")
            newdays.append(c)
           

        }
    
    return newdays
}

