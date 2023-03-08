//
//  ContentView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/25/23.
//

import SwiftUI

struct ScrumView: View {
    @Binding var standup: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(standup.theme.mainColor)
            VStack {
                StandupHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: standup.theme)
                Circle().strokeBorder(lineWidth: 24, antialiased: true)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed")
                            .font(.caption)
                        Label("300", systemImage: "hourglass.bottomhalf.fill")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining")
                            .font(.caption)
                        Label("600", systemImage: "hourglass.tophalf.fill")
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .accessibilityValue("10 minutes")
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(standup.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(standup: .constant(DailyScrum.sampleData[0]))
    }
}
