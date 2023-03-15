//
//  ScrumsView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/28/23.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var standups: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewStandupView = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($standups) { $standups in
                NavigationLink(destination: DetailView(standup: $standups)) {
                    CardView(scrum: standups)
                }
                .listRowBackground(standups.theme.mainColor)
            }
        }
        .navigationTitle("Daily Stand-ups")
        .toolbar {
            Button(action: {
                isPresentingNewStandupView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Stand-up")
        }
        .sheet(isPresented: $isPresentingNewStandupView) {
            NavigationView {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewStandupView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newStandup = DailyScrum(data: newScrumData)
                                standups.append(newStandup)
                                isPresentingNewStandupView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase != .active { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(standups: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
