//
//  ContentView.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var myweather: MyWeather
    @EnvironmentObject var settings: Settings
    @State private var showPrefs = false
    
    var body: some View
    {
        ZStack
        {
            VStack (alignment:.center,spacing:15.0)
            {
                Text("Weather")
                    .foregroundColor(settings.topTitleColor)
                    .font(settings.hugeFont)
                
                Rectangle()
                    .stroke(Color.black)
                    .frame(width: 500, height: 1)
                
                TemperatureBlock(myweather: myweather)
                HourForecastBlock(myweather: myweather)
                DayForecastBlock(myweather: myweather)
                
                HStack(spacing: 370.0)
                {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                        .frame(alignment: .leading)
                        .onTapGesture
                    {
                        withAnimation
                        {
                            showPrefs = true
                        }
                    }
                    
                    Image(systemName: "power.circle.fill")
                        .imageScale(.large)
                        .frame(alignment: .trailing)
                        .onTapGesture
                    {
                        print("quit")
                    }
                }
                .frame(width: 500.0,height: 20,alignment:.bottom)
                .padding(settings.blockPadding)
                .font(settings.mainFont)
                .foregroundColor(Color.gray)
                .background(settings.blockColor)
            }
            
            if $showPrefs.wrappedValue
            {
                VStack
                {
                    showPrefsView()
                    
                    Button(action: {
                               withAnimation {
                                   self.showPrefs = false
                                }
                            }, label: {
                                    Text("Close")
                            })
                }
            }
        }
    }
    


    private func showPrefsView() -> some View
    {
        Prefs()
    }
            
}
