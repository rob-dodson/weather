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
    let tintColor = Color(hex:"#bbbbbb")
    let symbolColor = Color(hex:"#03a3ff")
    let titleColor = Color(hex:"#ff5f03")
    let topTitleColor = Color(hex:"#03a3ff")
    let blockColor = Color(hex:"#000000")
    
    let hugeFont = Font.system(size: 40,weight: .bold)
    let titleFont = Font.system(size: 35.0)
    let headingFont = Font.system(size: 18.0)
    let mainFont = Font.system(size: 15.0)
    let smallFont = Font.system(size: 10.0)
    
    let blockPadding = 8.0
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
   
    

