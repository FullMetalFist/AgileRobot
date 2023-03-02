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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(standup: DailyScrum.sampleData[2])
        }
    }
}
