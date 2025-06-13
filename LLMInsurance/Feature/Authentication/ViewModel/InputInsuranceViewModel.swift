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

    // 검색 결과를 위한 예시 데이터
    let insuranceData = [
        "삼성생명",
        "국민생명",
        "하나생명",
        "신한생명",
        "현대생명",
        "미래생명",
        "한화생명",
    ]

    var filteredInsurance: [String] {
        guard !searchInsurance.isEmpty else { return [] }
        return insuranceData.filter {
            $0.contains(searchInsurance) && !myInsurance.contains($0)
        }
    }

    func addInsurance(_ insurance: String) {
        if !myInsurance.contains(insurance) {
            myInsurance.append(insurance)
            searchInsurance = ""
        }
    }

    func removeInsurance(_ insurance: String) {
        myInsurance.removeAll { $0 == insurance }
    }

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
