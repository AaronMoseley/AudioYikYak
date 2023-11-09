//
//  Item.swift
//  rekord
//
//  Created by Seun Adekunle on 11/8/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
