//
//  DetailEditView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/6/23.
//

import SwiftUI

struct DetailEditView: View {
    @State private var data = DailyScrum.Data()
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 5) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
