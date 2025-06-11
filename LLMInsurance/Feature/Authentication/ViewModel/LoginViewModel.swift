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
    @Published var isPasswordWrong: Bool = false
    @Published var passwordErrorMessage: String = ""
    @Published var isLoading: Bool = false

    // 로그인 테스트 용
    let correctId = "test"
    let correctPassword = "1234"

    func handleLogin() {
        isPasswordWrong = false
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            if id == correctId && password == correctPassword {
                isPasswordWrong = false
                passwordErrorMessage = ""
                // 로그인 성공 처리
            } else {
                isPasswordWrong = true
                passwordErrorMessage = "로그인 정보가 올바르지 않습니다"
            }
            isLoading = false
        }
    }
}
