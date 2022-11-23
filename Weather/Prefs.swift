//
//  Prefs.swift
//  Weather
//
//  Created by Robert Dodson on 11/18/22.
//

import SwiftUI

struct Prefs: View
{
    @ObservedObject var settings: Settings
    
    let themesize = 20.0
    
    var body: some View
    {
        
        
        VStack(spacing: 100)
        {
            Text("Settings")
                .frame(alignment:.topLeading)
            
            
            VStack (alignment:.leading)
            {
                Text("Themes")
                    .frame(alignment:.topLeading)
                
                ForEach(0 ..< settings.themes.count)
                { index in
                    
                    HStack(alignment: .center)
                    {
                        Button()
                        {
                            pickTheme(index:index)
                          
                        }
                        label:
                        {
                            if settings.themes[index].name == settings.theme.name
                            {
                                Image(systemName: "checkmark")
                            }
                            else
                            {
                                Image(systemName: "circle")
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(alignment: .leading)
                        
                        Text(settings.themes[index].name)
                                
                        let theme = settings.themes[index]
                        HStack()
                        {
                            Rectangle().fill(theme.blockColor).frame(width: themesize, height: themesize)
                            Rectangle().fill(theme.headerColor).frame(width: themesize, height: themesize)
                            Rectangle().fill(theme.symbolColor).frame(width: themesize, height: themesize)
                            Rectangle().fill(theme.textColor).frame(width: themesize, height: themesize)
                            Rectangle().fill(theme.titleColor).frame(width: themesize, height: themesize)
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
   
    func pickTheme(index:Int)
    {
        settings.theme = settings.themes[index]
    }
}
