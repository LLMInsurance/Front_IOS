//
//  LoginView.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
            }
        }
        .navigationTitle("로그인")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
