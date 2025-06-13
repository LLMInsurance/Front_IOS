//
// InputInoformationViewModel.swift
// LLMInsurance
//
// Created by 안홍범 on 6/11/25.
//

import SwiftUI

@MainActor
class InputInformationViewModel: ObservableObject {
    @Published var name: String = ""  // 이름
    @Published var birthDate: String = ""  // 생년월일
    @Published var phoneNumber: String = ""  // 전화번호
    @Published var gender: String = ""  // 성별
    @Published var isMarried: Bool = false  // 결혼 여부
    @Published var job: String = ""  // 직업

    @Published var isLoading: Bool = false  // 로딩 여부
    @Published var isNextView: Bool = false  // 다음 정보 입력뷰로 이동 여부

    // 다음 정보 입력뷰로 이동
    func goToNextView() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.isNextView = true
        }
    }

}
