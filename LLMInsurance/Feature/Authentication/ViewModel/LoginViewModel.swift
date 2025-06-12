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
    @Published var id: String = ""  // 아이디
    @Published var password: String = ""  // 비밀번호
    @Published var isPasswordVisible: Bool = false  // 비밀번호 보임 여부

    @Published var alertMessage: String = ""  // 알림 메시지
    @Published var isAlertPresented: Bool = false  // 알림 표시 여부
    @Published var showAlert: Bool = false  // 알림 표시 여부

    @Published var isLoginSuccess: Bool = false  // 로그인 성공 여부
    @Published var isPasswordWrong: Bool = false  // 비밀번호 오류 여부
    @Published var passwordErrorMessage: String = ""  // 비밀번호 오류 메시지
    @Published var isLoading: Bool = false  // 로딩 여부

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
