//
//  StandupHeaderView.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/8/23.
//

import SwiftUI

struct StandupHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(secondsRemaining)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        ProgressView(value: 5, total: 15)
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
    }
}

struct StandupHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StandupHeaderView(secondsElapsed: 60, secondsRemaining: 180)
            .previewLayout(.sizeThatFits)
    }
}
