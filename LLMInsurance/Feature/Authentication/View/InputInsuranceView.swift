//
//  InputInsuranceView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/12/25.
//

import SwiftUI

struct InputInsuranceView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ScrollView {  // 보험 입력 뷰
                InputInsuranceInformationView()
            }
            .onTapGesture {
                endTextEditing()
            }
        }
        .navigationTitle("회원 가입 (4/4)")
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

// MARK: - 보험 입력 뷰
struct InputInsuranceInformationView: View {
    @StateObject private var viewModel = InputInsuranceViewModel()
    @FocusState private var focusedField: Field?

    enum Field {  // 포커스 관리용 열거형
        case searchInsurance
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("보험 가입 내역")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryBlue)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            // 보험 가입 여부
            Toggle(isOn: $viewModel.isInsurance) {
                Text("보험 가입 여부")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .tint(Color.primaryBlue)

            if viewModel.isInsurance {
                // 보험 검색 창
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("보험 검색", text: $viewModel.searchInsurance)
                        .focused($focusedField, equals: .searchInsurance)
                        .submitLabel(.search)
                        .onSubmit {
                            // 검색 로직 구현하기
                        }
                        .frame(height: 22)
                        .textInputAutocapitalization(.never)
                }
                .inputFieldStyle(isFocused: focusedField == .searchInsurance)

                // 검색 결과 표시

            }

            // 회원 가입 완료 버튼
            Spacer().frame(height: 32)
            Button(action: {
                viewModel.goToNextView()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                } else {
                    Text("회원 가입 완료")
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
            LoginView()
        }
    }
}

struct InputInsuranceView_Previews: PreviewProvider {
    static var previews: some View {
        InputInsuranceView()
    }
}
