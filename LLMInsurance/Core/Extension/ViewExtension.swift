//
//  ViewExtension.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI
import UIKit

extension View {
    // 키보드 내리기
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil as AnyObject?,
            from: nil as AnyObject?,
            for: nil
        )
    }
}
