//
//  Settings.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import Foundation
import SwiftUI
import Combine

class Settings: Combine.ObservableObject
{
    var tintColor : Color
    var symbolColor : Color
    var titleColor : Color
    var topTitleColor : Color
    var blockColor : Color
    
    let colors: [String] =
    ["#bbbbbb",
    "#03a3ff",
    "#ff5f03",
    "#03a3ff",
    "#000000"]
    
    
    let hugeFont = Font.system(size: 40,weight: .bold)
    let titleFont = Font.system(size: 35.0)
    let headingFont = Font.system(size: 18.0)
    let mainFont = Font.system(size: 15.0)
    let smallFont = Font.system(size: 10.0)
    
    let blockPadding = 8.0
    
    init()
    {
        tintColor = Color(hex:colors[0])
        symbolColor = Color(hex:colors[1])
        titleColor = Color(hex:colors[2])
        topTitleColor = Color(hex:colors[3])
        blockColor = Color(hex:colors[4])
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
            red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
            blue:  CGFloat((rgb &     0xFF)      )/255.0)
    }
}
   
    

