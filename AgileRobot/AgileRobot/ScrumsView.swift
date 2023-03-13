//
//  ScrumsView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 2/28/23.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var standups: [DailyScrum]
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
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Stand-up")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(standups: .constant(DailyScrum.sampleData))
        }
    }
}
