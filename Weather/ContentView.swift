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
    @ObservedObject var settings: Settings
    @State var showPrefs = false
    
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Text("Weather")
                    .frame(width: 450,height: 45,alignment:.top)
                    .foregroundColor(settings.theme.titleColor)
                    .font(settings.hugeFont)
                
                ScrollView(showsIndicators: false)
                {
                    VStack (alignment:.center,spacing:15.0)
                    {
                        TemperatureBlock(myweather: myweather,settings: settings)
                        HourForecastBlock(myweather: myweather,settings: settings)
                        DayForecastBlock(myweather: myweather,settings: settings)
                    }
                }
                .frame(width: 475,height: CGFloat.minimum(970,((NSScreen.main?.frame.height)!) - 200.0),alignment: .center)
                
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
                    
                    Image(systemName: "power.circle")
                        .imageScale(.large)
                        .frame(alignment: .trailing)
                        .onTapGesture
                    {
                        print("quit")
                        exit(0)
                    }
                    
                }
                .frame(width: 475,height: 20,alignment:.bottom)
                .padding(.vertical)
                .font(settings.mainFont)
                .foregroundColor(Color.gray)
                .background(settings.theme.blockColor)
            }
            .popover(isPresented: $showPrefs,arrowEdge:.leading)
            {
                Prefs(settings:settings)
            }
              
        }
    }
}
