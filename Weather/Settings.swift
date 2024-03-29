//
//  Settings.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import Foundation
import SwiftUI
import Combine


struct Theme : Identifiable
{
    enum colorName : String
    {
        case text = "text"
        case symbol = "symbol"
        case block = "block"
        case title = "title"
        case header = "header"
        case wind = "wind"
        case precip = "percip"
        case hitemp = "hitemp"
        case lowtemp = "lowtemp"
    }
    
    var textColor : Color
    var symbolColor : Color
    var headerColor : Color
    var titleColor : Color
    var blockColor : Color
    var windColor : Color
    var precipColor : Color
    var hitempColor : Color
    var lowtempColor : Color
    
    var name: String
    var colors : Dictionary<String,Color>
    var id : UUID
    
    init(name: String, colors:Dictionary<String,Color>)
    {
        self.name = name
        self.id = UUID()
        self.colors = colors
        
        self.textColor = colors[colorName.text.rawValue] ?? Color.gray
        self.symbolColor = colors[colorName.symbol.rawValue] ?? Color.blue
        self.headerColor = colors[colorName.header.rawValue] ?? Color.white
        self.titleColor = colors[colorName.title.rawValue] ?? Color.white
        self.blockColor = colors[colorName.block.rawValue] ?? Color.black
        self.windColor = colors[colorName.wind.rawValue] ?? Color.pink
        self.precipColor = colors[colorName.precip.rawValue] ?? Color.yellow
        self.hitempColor = colors[colorName.hitemp.rawValue] ?? Color.green
        self.lowtempColor = colors[colorName.lowtemp.rawValue] ?? Color.blue
    }
    
    func color(name:colorName) -> Color
    {
        return colors[name.rawValue] ?? Color.white
    }
}


class Settings: ObservableObject
{
    @Published var theme : Theme
            
    var themes : [Theme]
    
    
    var prefsBlockColor = Color(red: 0.2, green: 0.2, blue: 0.2)
    
    let fontsize = 40.0
    
    let hugeFont : Font
    let titleFont : Font
    let headingFont : Font
    let mainFont : Font
    let smallFont : Font
    let screen = NSScreen()
    
    let blockPadding = 8.0
    
    init()
    {
        themes = Array<Theme>()
        let themeNames = ["Hyper","Serious"]
        
        for index in 0..<themeNames.count
        {
            let colors = [Theme.colorName.text.rawValue:Color("text\(index)"),
                           Theme.colorName.symbol.rawValue:Color("symbol\(index)"),
                           Theme.colorName.title.rawValue:Color("title\(index)"),
                           Theme.colorName.block.rawValue:Color("block\(index)"),
                           Theme.colorName.header.rawValue:Color("header\(index)")]
            
            let theme = Theme(name: themeNames[index], colors: colors)
            themes.append(theme)
        }

        theme = themes[0]
        
         hugeFont = Font.system(size: fontsize,weight: .bold)
         titleFont = Font.system(size: fontsize - 5.0)
         headingFont = Font.system(size: fontsize - 22.0)
         mainFont = Font.system(size: fontsize - 25.0)
         smallFont = Font.system(size: fontsize - 30.0)
    }
}

extension Color
{
    init(hex: String, alpha: CGFloat = 1)
    {
        let scanner = Scanner(string: hex)
        var set = CharacterSet()
        set.insert("#")
        scanner.charactersToBeSkipped = set
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb &   0xFF00) >>  8) / 255.0,
            blue:  CGFloat((rgb &     0xFF)      ) / 255.0)
    }
}
   
    

