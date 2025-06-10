//
//  LoginView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    @State private var shakeTrigger: CGFloat = 0

    enum Field {
        case id, password
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                // 이메일 입력
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    TextField("아이디를 입력하세요", text: $viewModel.id)
                        .focused($focusedField, equals: .id)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .password
                        }
                        .frame(height: 22)
                }
                .padding()
                .background(
                    (focusedField == .id ? Color.white : Color(.systemGray6))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(focusedField == .id ? Color.primaryBlue : Color.clear, lineWidth: 2)
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                )
                .cornerRadius(50)

                // 비밀번호 입력
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    if viewModel.isPasswordVisible {
                        TextField("비밀번호를 입력하세요", text: $viewModel.password)
                            .id("password")
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .frame(height: 22)
                    } else {
                        SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                            .id("password")
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .frame(height: 22)
                    }
                    Button(action: { viewModel.isPasswordVisible.toggle() }) {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(
                    (focusedField == .password ? Color.white : Color(.systemGray6))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(
                            viewModel.isPasswordWrong
                                ? Color.red
                                : (focusedField == .password ? Color.primaryBlue : Color.clear),
                            lineWidth: 2
                        )
                        .animation(.easeInOut(duration: 0.2), value: viewModel.isPasswordWrong)
                )
                .cornerRadius(50)
                .warning(shakeTrigger)

                // 경고문
                if viewModel.isPasswordWrong {
                    Text(viewModel.passwordErrorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.leading, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Login 버튼
                Button(action: {
                    focusedField = nil  // 키보드 닫기
                    viewModel.handleLogin()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("로그인")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.primaryBlue)
                .foregroundColor(.white)
                .cornerRadius(50)
                .disabled(viewModel.isLoading)
                .padding(.top, 16)

                // Sign Up 링크
                HStack {
                    Text("아직 회원이 아니신가요?")
                        .foregroundColor(.gray)
                    NavigationLink("회원가입", destination: SignUpView())
                        .foregroundColor(Color.primaryBlue)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: 400)
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        endTextEditing()
                    }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("로그인")
        .onChange(of: viewModel.isPasswordWrong) { isWrong in
            if isWrong {
                withAnimation(.default) {
                    shakeTrigger += 1
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
