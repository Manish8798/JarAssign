//
//  SwiftDataModel.swift
//  Assignment
//
//  Created by Evolve on 22/01/2025.
//

import Foundation
import SwiftData

@Model
class SwiftDataModel {
    var deviceName: String
    var color: String?
    var price: Double?
    
    init(deviceName: String, color: String, price: Double) {
        self.deviceName = deviceName
        self.color = color
        self.price = price
    }
}
