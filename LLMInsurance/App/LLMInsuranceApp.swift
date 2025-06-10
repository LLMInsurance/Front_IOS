//
//  LLMInsuranceApp.swift
//  LLMInsurance
//
//  Created by 안홍범 on 6/10/25.
//

import SwiftData
import SwiftUI

@main
struct LLMInsuranceApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            OnBoardingView()
        }
        .modelContainer(sharedModelContainer)
    }
}
