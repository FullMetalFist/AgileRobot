//
//  AgileRobotApp.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/25/23.
//

import SwiftUI

@main
struct AgileRobotApp: App {
    @StateObject private var store = StandupStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(standups: $store.standups) {
                    Task {
                        do {
                            try await StandupStore.save(standups: store.standups)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later")
                        }
                    }
                }
            }
            .task {
                do {
                    store.standups = try await StandupStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "AgileRobot will load sample data and continue")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.standups = DailyScrum.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
