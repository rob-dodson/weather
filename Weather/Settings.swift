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
    
    var tintColor = Color.orange
    {
        willSet
        {
            willChange.send()
        }
    }
    
    var titleColor = Color(red: 0.8, green: 0.8, blue: 0.3)
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
