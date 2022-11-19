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
    var name: String
    var colors : Dictionary<String,Color>
    var id : UUID
    
    init(name: String, colors:Dictionary<String,Color>)
    {
        self.name = name
        self.id = UUID()
        self.colors = colors
    }
}


class Settings: Combine.ObservableObject
{
    var tintColor : Color
    var symbolColor : Color
    var titleColor : Color
    var topTitleColor : Color
    var blockColor : Color
    var themes : [Theme]
    
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
        
        let colors = ["tintColor":Color(hex:"#bbbbbb"),
            "symbolColor":Color(hex:"#03a3ff"),
            "topTitleColor":Color(hex:"#03a3ff"),
            "blockColor":Color(hex:"#000000"),
            "titleColor":Color(hex:"#ff5f03")]
        
        let theme = Theme(name: "default", colors: colors)
        themes.append(theme)
        
        let colors2 = ["tintColor":Color(hex:"#bbbbbb"),
            "symbolColor":Color(hex:"#03a3ff"),
            "topTitleColor":Color(hex:"#03a3ff"),
            "blockColor":Color(hex:"#000000"),
            "titleColor":Color(hex:"#ff5f03")]
        
        let theme2 = Theme(name: "default", colors: colors2)
        themes.append(theme2)
        
        tintColor = theme.colors["tintColor"]!
        symbolColor = theme.colors["symbolColor"]!
        titleColor = theme.colors["titleColor"]!
        topTitleColor = theme.colors["topTitleColor"]!
        blockColor = theme.colors["blockColor"]!
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
   
    

