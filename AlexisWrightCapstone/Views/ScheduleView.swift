//
//  ContentView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/25/23.
//

import SwiftUI

struct ScheduleView: View {
    let colors = Colors()
    
    @State private var sleepTime: Alarm = Alarm(alarm: Date())
    @State private var sleepOrWake: SleepWake = .wakeUp
    
    var body: some View {
//        if alarm set, we good. if not, we bad
        ZStack {
            VStack {
                VStack {
                    Text("I need to ")
                    Picker("Go To Sleep or Wake Up", selection: $sleepOrWake) {
                        ForEach(SleepWake.allCases){ option in
                            Text(option.description)
                        }
                    }
                    .pickerStyle(.automatic)
                    Text("at")
                    DatePicker("", selection: $sleepTime.alarm, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } //I want to [Something] at [Time]
                NavigationLink(destination: TimeView(sleepWake: sleepOrWake, userSetBedtime: sleepTime)) {
                    Text("Go")
                }
            }
            .padding(20)
        }//zstack for UI
    }//Body
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
