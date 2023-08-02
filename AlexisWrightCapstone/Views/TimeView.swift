//
//  TimeView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/26/23.
//

import SwiftUI

struct TimeView: View {

    var sleepWake: SleepWake
    var goalTime: Alarm
    
    let colors = Colors()
    var willGoToSleep: Bool {
        sleepWake == .goToSleep ? true : false
    }
    var bedtime: String {
        willGoToSleep ? "bedtime" : "wake up time"
    }
    var alarms: [Alarm] {
        willGoToSleep ? generateMorningAlarms(goalTime.alarm) : generateEveningAlarms(goalTime.alarm)
    }
    @State private var showingAlert = false
    
    var numInArray = 0
    @State private var alertTitle = ""
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Based on your \(bedtime) of")
                    Text(goalTime.hourMinAlarm)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Text("You have the following options of alarms:")
                    
                } //Intro Text + Goal Time
                Spacer()
                VStack {
                    List {
                        ForEach(alarms, id: \.self) { alarm in
                            NavigationLink(destination: AlarmView(alarm: alarm)) {
                                Text(alarm.hourMinAlarm)
                                    .foregroundColor(numInArray > 1 ? .green : .red)
                            }
//                            .alert(isPresented: $showingAlert) {
//                                Alert(title: Text("Setting Alarm"), message: "Are you sure you want to set alarm for \(myAlarm)?", dismissButton: nil)
//                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                }
                .font(.system(size: 40))
                .fontWeight(.bold)
            } //Total Content
            .padding(30)

        }
    }
    private func formatDateToStringHrMin(date: Date) -> String {
        return date.formatted(.dateTime.hour().minute())
    }
    private func generateMorningAlarms(_ setTime: Date) -> [Alarm] {
        //sleep cycle Info Here
        //figure ou t90 minute cycles going from the timeSet
        return [Alarm(alarm: Date()), Alarm(alarm: Date(timeIntervalSince1970: 1691009835))]
    }
    private func generateEveningAlarms(_ setTime: Date) -> [Alarm] {
        //Sleep Cycle Info HERE
        return [Alarm(alarm: Date()), Alarm(alarm: Date(timeIntervalSince1970: 1691009835))]
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(sleepWake: SleepWake.goToSleep, goalTime: Alarm(alarm: Date()))
    }
}
