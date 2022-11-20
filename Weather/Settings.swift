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
        self.windColor = colors[colorName.wind.rawValue] ?? Color.red
        self.precipColor = colors[colorName.precip.rawValue] ?? Color.blue
        self.hitempColor = colors[colorName.hitemp.rawValue] ?? Color.green
        self.lowtempColor = colors[colorName.lowtemp.rawValue] ?? Color.yellow
    }
    
    func color(name:colorName) -> Color
    {
        return colors[name.rawValue] ?? Color.white
    }
}


class Settings: Combine.ObservableObject
{
    var themes : [Theme]
    var theme : Theme
    
    var prefsBlockColor = Color(red: 0.2, green: 0.2, blue: 0.2)
    
    let hugeFont = Font.system(size: 40,weight: .bold)
    let titleFont = Font.system(size: 35.0)
    let headingFont = Font.system(size: 18.0)
    let mainFont = Font.system(size: 15.0)
    let smallFont = Font.system(size: 10.0)
    
    let blockPadding = 8.0
    
    init()
    {
        themes = Array<Theme>()
        
        let colors = [Theme.colorName.text.rawValue:Color(hex:"#bbbbbb"),
                      Theme.colorName.symbol.rawValue:Color(hex:"#03a3ff"),
                      Theme.colorName.title.rawValue:Color(hex:"#03a3ff"),
                      Theme.colorName.block.rawValue:Color(hex:"#000000"),
                      Theme.colorName.header.rawValue:Color(hex:"#ff9636")]
        
        let theme1 = Theme(name: "Hyper", colors: colors)
        themes.append(theme1)
        
        let colors2 = [Theme.colorName.text.rawValue:Color(hex:"#738fa7"),
                       Theme.colorName.symbol.rawValue:Color(hex:"#0c4160"),
                       Theme.colorName.title.rawValue:Color(hex:"#3ceda"),
                       Theme.colorName.block.rawValue:Color(hex:"#071330"),
                       Theme.colorName.header.rawValue:Color(hex:"#3ceda")]
        
        let theme2 = Theme(name: "Serious", colors: colors2)
        themes.append(theme2)

        theme = theme1
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
   
    

