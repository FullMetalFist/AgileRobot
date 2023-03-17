//
//  ContentView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/25/23.
//

import SwiftUI
import AVFoundation

struct ScrumView: View {
    @Binding var standup: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(standup.theme.mainColor)
            VStack {
                StandupHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: standup.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, theme: standup.theme)
                StandupFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(standup.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: standup.lengthInMinutes, attendees: standup.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            let newHistory = History(attendees: standup.attendees, lengthInMinutes: standup.lengthInMinutes)
            standup.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(standup: .constant(DailyScrum.sampleData[0]))
    }
}
