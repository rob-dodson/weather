//
//  Settings.swift
//  Weather
//
//  Created by Robert Dodson on 11/6/22.
//

import Foundation
import SwiftUI
import Combine

class Settings: Combine.ObservableObject {
    
    var willChange = PassthroughSubject<Void, Never>()
    
    var tintColor = Color(hex:"#848484")
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var symbolColor = Color(hex:"#03a3ff")
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var titleColor = Color(hex:"#ff5f03")
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var topTitleColor = Color(hex:"#fff4ee")
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var blockColor = Color(hex:"#030100")
    {
        willSet
        {
            willChange.send()
        }
    }
    
}

    extension Color
    {
        init(hex: String, alpha: CGFloat = 1)
        {
            assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
            
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
   
    

