//
//  User.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    private(set) var id: UUID = UUID()
    var name: String
    var userId: String
    var password: String

    init(
        id: UUID, name: String,
        userId: String,
        password: String
    ) {
        self.id = id
        self.name = name
        self.userId = userId
        self.password = password
    }
}
