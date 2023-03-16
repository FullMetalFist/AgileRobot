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
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(standups: $store.standups) {
                    Task {
                        do {
                            try await StandupStore.save(standups: store.standups)
                        } catch {
                            fatalError("Error saving standups")
                        }
                    }
                }
            }
            .task {
                do {
                    store.standups = try await StandupStore.load()
                } catch {
                    fatalError("Error loading scrums")
                }
            }
        }
    }
}
