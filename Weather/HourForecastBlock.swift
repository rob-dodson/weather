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
                        .frame(width: 20.0,height: 20.0,alignment: .center)
                    
                    Text("Hourly Forecast")
                        .foregroundColor(settings.theme.headerColor)
                        .font(.title2)
                }
                
                
                let hours = weather.hourlyForecast
                HStack(spacing: 15.0)
                {
                    ForEach(hours.indices)
                    { index in
                        let hour = hours[index]
                        if hour.date.timeIntervalSinceNow > 0 && hour.date.timeIntervalSinceNow < (60 * 60 * 8)
                        {
                            VStack(spacing: 5.0)
                            {
                                Image(systemName: "\(hour.symbolName)")
                                    .imageScale(.medium)
                                    .foregroundColor(settings.theme.symbolColor)
                                
                                Text("\(hour.date.formatted(Date.FormatStyle().hour()))")
                            }
                        }
                    }
                }
                .foregroundColor(settings.theme.textColor)
                .font(settings.mainFont)
                
                let newhours = convert(oldweatherdata:hours)
                Chart(newhours)
                {
                    LineMark(
                        x: .value("Date", $0.date),
                        y: .value("Val", $0.val)
                    )
                    .foregroundStyle(by: .value("type", $0.type))
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
                .chartPlotStyle { plotArea in
                    plotArea
                    .background(.blue.opacity(0.3))
                }
                .frame(width:420,height:100)
                .chartForegroundStyleScale([
                    "Temp" : settings.theme.hitempColor,
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


struct hourdata : Identifiable
{
    var date : Date
    var val : Double
    var type : String
    var id = UUID()
}


func convert(oldweatherdata:Forecast<HourWeather>) -> [hourdata]
{
        var newhours = Array<hourdata>()
    
        for oldhour in oldweatherdata
        {
            if oldhour.date.timeIntervalSinceNow > 0 && oldhour.date.timeIntervalSinceNow < (60 * 60 * 8)
            {
                let hitemp = oldhour.temperature.converted(to: .fahrenheit).value
                
                let a = hourdata(date: oldhour.date, val: hitemp,type:"Temp")
                newhours.append(a)
                let c = hourdata(date: oldhour.date, val: oldhour.precipitationChance * 100.0,type:"Precip Chance")
                newhours.append(c)
                let d = hourdata(date: oldhour.date, val: oldhour.wind.speed.value,type:"Wind")
                newhours.append(d)
            }
        }
    
    return newhours
}
