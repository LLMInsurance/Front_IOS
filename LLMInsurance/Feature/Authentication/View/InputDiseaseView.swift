//
//  InputDiseaseView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/12/25.
//

import SwiftUI

struct InputDiseaseView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ScrollView {  // 질병 입력 뷰
                InputDiseaseInformationView()
            }
        }
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    endTextEditing()
                }
        )
        .navigationTitle("회원 가입")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxWidth: 400)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

// MARK: - 질병 입력 뷰
struct InputDiseaseInformationView: View {
    @StateObject private var viewModel = InputDiseaseViewModel()

    let diseaseOptions = [
        "암 (위암, 폐암, 유방암 등)",
        "심혈관계 질환 (고혈압, 협심증, 심근경색 등)",
        "뇌혈관 질환 (뇌졸중, 뇌출혈 등)",
        "당뇨병",
        "간질환 (간경화, B형간염 등)",
        "폐질환 (천식, 만성폐쇄성폐질환 등)",
        "근골격계/척추질환 (디스크, 관절염 등)",
        "정신질환 (우울증, 불안장애 등)",
        "기타 만성질환 (신장질환, 갑상선질환 등)",
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("현재 해당하는 사항을 모두 선택해 주세요")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryBlue)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(diseaseOptions, id: \.self) { disease in
                Button(action: {
                    if viewModel.selectedDiseases.contains(disease) {
                        viewModel.selectedDiseases.removeAll { $0 == disease }
                    } else {
                        viewModel.selectedDiseases.append(disease)
                    }
                }) {
                    HStack {
                        Image(
                            systemName: viewModel.selectedDiseases.contains(disease)
                                ? "checkmark.square" : "square"
                        )
                        .foregroundColor(.blue)
                        Text(disease)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .padding(.vertical, 4)
            }

            Spacer().frame(height: 32)
            Button(action: {
                viewModel.goToNextView()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                } else {
                    Text("다음")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.primaryBlue)
            .foregroundColor(.white)
            .cornerRadius(50)
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.isNextView) {
            // InputDiseaseView()
        }
    }
}

struct InputDiseaseView_Previews: PreviewProvider {
    static var previews: some View {
        InputDiseaseView()
    }
}
