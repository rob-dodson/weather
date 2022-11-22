//
//  WeatherApp.swift
//  Weather
//
//  Created by Robert Dodson on 6/20/22.
//

import SwiftUI

/*
@main
struct WeatherApp: App
{
    @StateObject private var myweather : MyWeather = MyWeather.shared

    var body: some Scene
    {
        WindowGroup
        {
            ContentView(myweather: myweather).environmentObject(Settings())
        }
    }
}
*/

@main
struct WeatherApp: App
{
    @StateObject private var myweather : MyWeather = MyWeather.shared
    @State private var showPrefs = false
    
    
    var body: some Scene
    {
        let settings = Settings();
        
        
        MenuBarExtra("Weather", systemImage: "cloud.sun.fill")
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
                        ContentView(myweather: myweather).environmentObject(Settings())
                        // .background() { Image("back1") }
                    }
                    .frame(width: 475,height: CGFloat.minimum(900,((NSScreen.main?.frame.height)!) - 100.0),alignment: .center)
                    
                    
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
        .menuBarExtraStyle(.window)
            
    }
    
    
    private func showPrefsView() -> some View
    {
        Prefs()
    }
}
