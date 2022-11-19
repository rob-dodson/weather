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
                ForEach(settings.themes)
                { theme in
                    HStack
                    {
                        Rectangle()
                            .fill(theme.colors["tintColor"]!)
                            .frame(width: themesize, height: themesize)
                        Rectangle()
                            .fill(theme.colors["symbolColor"]!)
                            .frame(width: themesize, height: themesize)
                        Rectangle()
                            .fill(theme.colors["titleColor"]!)
                            .frame(width: themesize, height: themesize)
                        Rectangle()
                            .fill(theme.colors["topTitleColor"]!)
                            .frame(width: themesize, height: themesize)
                        Rectangle()
                            .fill(theme.colors["blockColor"]!)
                            .frame(width: themesize, height: themesize)
                    }
                }
                
            }
            
        }
        .frame(width: 300, height: 300)
        .padding()
        .font(settings.mainFont)
        .foregroundColor(settings.tintColor)
        .background(settings.prefsBlockColor)
        .cornerRadius(15)
        .opacity(60.0)
    }
   
}
