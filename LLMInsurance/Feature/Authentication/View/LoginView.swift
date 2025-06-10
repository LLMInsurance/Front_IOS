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
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(50)

                // 비밀번호 입력
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    if viewModel.isPasswordVisible {  // 비밀번호 보이기 버튼
                        TextField("비밀번호를 입력하세요", text: $viewModel.password)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                    } else {
                        SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                    }
                    Button(action: { viewModel.isPasswordVisible.toggle() }) {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(50)

                // Login 버튼
                Button(action: {
                    focusedField = nil  // 키보드 닫기
                    viewModel.handleLogin()
                }) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }
                .padding(.top, 16)

                // Sign Up 링크
                HStack {
                    Text("아직 회원이 아니신가요?")
                        .foregroundColor(.gray)
                    NavigationLink("회원가입", destination: SignUpView())
                        .foregroundColor(.blue)
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
