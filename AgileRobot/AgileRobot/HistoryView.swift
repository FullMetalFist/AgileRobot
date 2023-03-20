//
//  HistoryView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/20/23.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                    Text(transcript)
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [DailyScrum.Attendee(name: "Dude"), DailyScrum.Attendee(name: "Dod")], lengthInMinutes: 10, transcript: "Dude, would you like to start today? Sure, yesterday I ate a thousand bagels and then ran..")
    }
    static var previews: some View {
        HistoryView(history: history)
    }
}
