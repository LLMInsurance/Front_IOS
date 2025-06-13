//
//  SignUpViewModel.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var id: String = ""  // 아이디
    @Published var idMessage: String  // 아이디 메시지
    @Published var isIdRuleWrong: Bool = false  // 아이디 규칙 오류 여부
    @Published var isIdDuplicated: Bool = false  // 아이디 중복 여부
    @Published var isIdChecked: Bool = false  // 중복 확인 여부

    @Published var password: String = ""  // 비밀번호
    @Published var confirmPassword: String = ""  // 비밀번호 확인
    @Published var isPasswordWrong: Bool = false  // 비밀번호 오류 여부
    @Published var passwordErrorMessage: String = ""  // 비밀번호 오류 메시지
    @Published var passwordNotMatchMessage: String = ""  // 비밀번호 일치 오류 메시지
    @Published var isPasswordRuleWrong: Bool = false  // 비밀번호 규칙 오류 여부
    @Published var isPasswordConfirmWrong: Bool = false  // 비밀번호 일치 오류 여부

    @Published var email: String = ""  // 이메일
    @Published var isLoading: Bool = false  // 로딩 여부
    @Published var isNextView: Bool = false  // 다음 정보 입력뷰로 이동 여부

    // 아이디 중복 테스트용
    let duplicatedId = "test123"

    // 규칙 메시지
    let idRuleMessage = "6~12자의 영문과 숫자를 모두 포함해야 합니다"
    let passwordRuleMessage = "8~16자의 영문 대 소문자 및 숫자만 사용 가능합니다"
    let passwordConfirmMessage = "비밀번호가 일치하지 않습니다"

    init() {
        // 초기 메시지 설정
        idMessage = idRuleMessage
        // 비밀번호 입력 오류 초기화
        isPasswordWrong = false
        passwordErrorMessage = ""
    }

    // 아이디 중복 확인
    func checkIdDuplication() {
        isIdChecked = true
        isIdDuplicated = id == duplicatedId

        if isIdDuplicated {
            idMessage = "이미 존재하는 아이디입니다."
        } else {
            idMessage = "사용 가능한 아이디입니다."
        }
    }

    // 아이디 규칙 확인
    func checkIdRule() {
        // 영문과 숫자를 모두 포함하는 정규식
        let pattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,12}$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: id.utf16.count)
        let matches = regex.firstMatch(in: id, options: [], range: range) != nil

        isIdRuleWrong = !matches

        // 아이디가 변경되면 중복 확인 상태 초기화
        if isIdChecked {
            isIdChecked = false
            isIdDuplicated = false
            idMessage = idRuleMessage
        }
    }

    // 비밀번호 규칙 확인
    func checkPasswordRule() {
        if password.count < 8 || password.count > 16
            || !password.allSatisfy({ $0.isLetter || $0.isNumber })
        {
            passwordErrorMessage = passwordRuleMessage
            isPasswordRuleWrong = true
        } else {
            passwordErrorMessage = ""
            isPasswordRuleWrong = false
        }
    }

    // 비밀번호 일치 확인
    func checkPasswordConfirm() {
        if !confirmPassword.isEmpty && password != confirmPassword {
            passwordNotMatchMessage = passwordConfirmMessage
            isPasswordConfirmWrong = true
        } else {
            passwordNotMatchMessage = ""
            isPasswordConfirmWrong = false
        }
    }

    // 다음 정보 입력뷰로 이동
    func goToNextView() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.isNextView = true
        }
    }
}
