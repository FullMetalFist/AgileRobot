//
//  DetailView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/2/23.
//

import SwiftUI

struct DetailView: View {
    let standup: DailyScrum
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: ScrumView()) {
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(standup.lengthInMinutes)")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(standup.theme.name).padding(4)
                        .foregroundColor(standup.theme.accentColor)
                        .background(standup.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach(standup.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(standup.title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(standup: DailyScrum.sampleData[2])
        }
    }
}
