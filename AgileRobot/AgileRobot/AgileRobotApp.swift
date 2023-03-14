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
                    StandupStore.save(standups: store.standups) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                StandupStore.load { result in
                    switch result {
                    case .success(let standups):
                        store.standups = standups
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
}
