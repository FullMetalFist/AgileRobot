//
//  AgileRobotApp.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/25/23.
//

import SwiftUI

@main
struct AgileRobotApp: App {
    @State private var standups = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $standups)
            }
        }
    }
}
