//
//  DetailView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/2/23.
//

import SwiftUI

struct DetailView: View {
    @Binding var standup: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: ScrumView(standup: $standup)) {
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
            Section(header: Text("History")) {
                if standup.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(standup.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(standup.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = standup.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(standup.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                standup.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(standup: .constant(DailyScrum.sampleData[0]))
        }
    }
}
