//
//  Item.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
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
