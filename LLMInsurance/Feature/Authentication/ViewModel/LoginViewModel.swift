//
//  LoginViewModel.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var alertMessage: String = ""
    @Published var isAlertPresented: Bool = false
    @Published var showAlert: Bool = false
    @Published var isLoginSuccess: Bool = false

    func handleLogin() {
        // TODO: 로그인 로직 구현
        print("Login with id: \(id), password: \(password)")
    }

    func handleGoogleLogin() {
        // TODO: 구글 로그인 구현
    }

    func handleAppleLogin() {
        // TODO: 애플 로그인 구현
    }
}
