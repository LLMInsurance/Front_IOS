//
//  SignUpView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftData
import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ScrollView {  // 가입 정보 입력 뷰
                InputView()
            }
        }
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    endTextEditing()
                }
        )
        .navigationTitle("회원가입")
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

// MARK: - 가입 정보 입력 뷰
struct InputView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @FocusState private var focusedField: Field?
    @State private var shakeTrigger: CGFloat = 0

    enum Field {  // 포커스 관리용 열거형
        case id, password, confirmPassword, email
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("로그인 정보")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryBlue)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            // 아이디 입력 (중복 확인 버튼 포함)
            HStack {
                Image(systemName: "person.text.rectangle")
                    .foregroundColor(.gray)
                TextField("아이디를 입력하세요", text: $viewModel.id)
                    .focused($focusedField, equals: .id)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                    .onChange(of: viewModel.id) {
                        viewModel.checkIdRule()
                    }
                    .frame(height: 22)
                    .textInputAutocapitalization(.never)
                Button(action: {
                    viewModel.checkIdDuplication()
                }) {
                    Text("중복 확인")
                        .font(.subheadline)
                        .foregroundColor(.primaryBlue)
                }
                .disabled(viewModel.id.isEmpty)
            }
            .inputFieldStyle(isFocused: focusedField == .id)
            .warning(shakeTrigger)

            // 비밀번호 입력
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .confirmPassword
                    }
                    .onChange(of: viewModel.password) {
                        viewModel.checkPasswordRule()
                    }
                    .frame(height: 22)
            }
            .inputFieldStyle(isFocused: focusedField == .password)

            if viewModel.isPasswordRuleWrong {  // 비밀번호 규칙 오류 시 메시지 표시
                Text(viewModel.passwordErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // 비밀번호 확인 입력
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("비밀번호를 다시 입력하세요", text: $viewModel.confirmPassword)
                    .focused($focusedField, equals: .confirmPassword)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .email
                    }
                    .onChange(of: viewModel.confirmPassword) {
                        viewModel.checkPasswordConfirm()
                    }
                    .frame(height: 22)
            }
            .inputFieldStyle(isFocused: focusedField == .confirmPassword)

            if viewModel.isPasswordConfirmWrong {  // 비밀번호 일치 오류 시 메시지 표시
                Text(viewModel.passwordErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // 이메일 입력
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("이메일을 입력하세요", text: $viewModel.email)
                    .focused($focusedField, equals: .email)
                    .frame(height: 22)
                    .textInputAutocapitalization(.never)
            }
            .inputFieldStyle(isFocused: focusedField == .email)

            Spacer().frame(height: 32)

            // 다음 버튼
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
            InputInformationView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
