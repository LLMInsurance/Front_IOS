//
//  LoginViewModel.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""

}
