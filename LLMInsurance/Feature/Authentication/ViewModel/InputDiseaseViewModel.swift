//
//  InputDiseaseViewModel.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/12/25.
//

import SwiftUI

@MainActor
class InputDiseaseViewModel: ObservableObject {
    @Published var selectedDiseases: [String] = []

    @Published var isLoading: Bool = false
    @Published var isNextView: Bool = false

    func goToNextView() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.isNextView = true
        }
    }
}
