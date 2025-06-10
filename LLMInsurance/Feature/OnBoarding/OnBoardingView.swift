//
//  OnBoardingView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Spacer()
                // 아이콘 + CareEasy 텍스트 묶기
                VStack(spacing: 16) {
                    Image("Icon")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Text("CareEasy")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.primaryBlue)
                }
                // 나머지 뷰
                VStack(spacing: 8) {
                    Text("Let's get started!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Login to enjoy the features we've\nprovided, and stay healthy!")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                }
                .padding(.bottom, 32)

                VStack(spacing: 16) {
                    // 로그인 뷰로 이동
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryBlue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }

                    // 회원가입 뷰로 이동
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.primaryBlue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        Color.primaryBlue,
                                        lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 32)
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
