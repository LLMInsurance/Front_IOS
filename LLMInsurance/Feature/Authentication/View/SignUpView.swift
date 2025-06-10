//
//  SignUpView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftData
import SwiftUI

struct SignUpView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("SignUp")
            }
        }
        .navigationTitle("회원가입")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
