//
//  ContentView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/17/23.
//

import SwiftUI

enum AppView: Codable, Hashable {
    case scheduleView(Alarm)
    case timeView(SleepWake, Alarm)
    case alarmView(Alarm)
}


struct ContentView: View {
    @State var navigationPath: [AppView] = []
    @ObservedObject var alarmManager = AlarmManager.shared
//    @ObservedObject var alarmSet = false
    var body: some View {
        NavigationStack(path: $navigationPath) {
            // if alarm is currently going
            // show alarmView
            // else
            // show ScheduleView
            if alarmManager.currentAlarm != nil {
                AlarmView(alarm: alarmManager.currentAlarm!)
            } else {
                ScheduleView()
                    .navigationDestination(for: AppView.self) { appView in
                        switch appView {
                        case .scheduleView(_):
                            ScheduleView()
                        case .timeView(let sleepWake, let alarm):
                            TimeView(sleepWake: sleepWake, userSetBedtime: alarm)
                        case .alarmView(let alarm):
                            AlarmView(alarm: alarm)
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

