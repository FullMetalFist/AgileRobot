//
//  MeetingTimerView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/17/23.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted})?.name ?? "Somebody"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is Speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bobby", isCompleted: true), ScrumTimer.Speaker(name: "Ricki", isCompleted: false)]
    }
    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: .yellow)
    }
}
