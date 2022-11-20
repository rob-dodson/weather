//
//  Prefs.swift
//  Weather
//
//  Created by Robert Dodson on 11/18/22.
//

import SwiftUI

struct Prefs: View
{
    @EnvironmentObject var settings: Settings
    
    let themesize = 20.0
    
    var body: some View
    {
        VStack
        {
            Text("Settings")
                .frame(alignment:.top)
            
            Text("Themes")
            
            VStack
            {
                ForEach(0 ..< settings.themes.count)
                { index in
                    
                    HStack
                    {
                        Button
                        {
                            print("button")
                        }
                        label:
                        {
                            Image(systemName: "checkmark")
                        }

                        Text(settings.themes[index].name)
                        
                        let colors  = Array(settings.themes[index].colors)
                        ForEach(colors.indices)
                        { idx in
                            Rectangle()
                                .fill(colors[idx].value)
                                .frame(width: themesize, height: themesize)
                        }
                    }
                }
                
            }
            
        }
        .frame(width: 300, height: 300)
        .padding()
        .font(settings.mainFont)
        .foregroundColor(settings.theme.textColor)
        .background(settings.prefsBlockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
   
}
