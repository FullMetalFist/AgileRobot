//
//  AgileRobotApp.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/25/23.
//

import SwiftUI

@main
struct AgileRobotApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
