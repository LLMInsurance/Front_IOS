//
//  InputInsuranceViewModel.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/12/25.
//

import SwiftUI

@MainActor
class InputInsuranceViewModel: ObservableObject {
    @Published var searchInsurance: String = ""
    @Published var myInsurance: [String] = []
    @Published var isInsurance: Bool = false

    @Published var isLoading: Bool = false
    @Published var isNextView: Bool = false

    // func searchInsurance() {  // 보험 검색
    //     isLoading = true
    //     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //         self.isLoading = false
    //     }
    // }

    func goToNextView() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.isNextView = true
        }
    }
}
