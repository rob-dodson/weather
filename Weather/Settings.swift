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
    
    var tintColor = Color.gray
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var symbolColor = Color.blue
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var titleColor = Color.orange
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var blockColor = Color(red: 0.2, green: 0.2, blue: 0.3)
    {
        willSet
        {
            willChange.send()
        }
    }
    
}
