//
//  OnBoardingView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 16) {
                Image("Icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("어플명")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color.primaryBlue)
            }
            // 나머지 뷰
            VStack(spacing: 8) {
                Text("1줄 소개")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("간략 소개")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

            }
            .padding(.bottom, 32)

            VStack(spacing: 16) {
                // 로그인 뷰로 이동
                NavigationLink(destination: LoginView()) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }

                // 회원가입 뷰로 이동
                NavigationLink(destination: SignUpView()) {
                    Text("회원가입")
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
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnBoardingView()
        }
    }
}
