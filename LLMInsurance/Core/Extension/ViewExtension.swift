//
//  ViewExtension.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftUI
import UIKit

struct WarningEffect: GeometryEffect {  // 틀림 효과(흔들림)
    var animatableData: CGFloat
    var amount: CGFloat = 8  // 흔들림 강도
    var shakeCount = 4  // 흔들림 횟수

    init(_ interval: CGFloat) {
        self.animatableData = interval
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi),
                y: 0
            ))
    }
}

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

    // 흔들림 효과
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(.default, value: interval)
    }
}
