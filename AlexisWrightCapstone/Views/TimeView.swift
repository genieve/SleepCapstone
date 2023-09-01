//
//  TimeView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/26/23.
//

import SwiftUI

struct TimeView: View {

    var sleepWake: SleepWake
    var userSetBedtime: Alarm
    
    let colors = Colors()
    
    var willGoToSleep: Bool {
        sleepWake == .goToSleep ? true : false
    }
    var bedtime: String {
        willGoToSleep ? "bedtime" : "wake up time"
    }
    var alarms: [Alarm] {
        willGoToSleep ? generateMorningAlarms(userSetBedtime.alarm) : generateEveningAlarms(userSetBedtime.alarm)
    }
        
//    var alarmManager = AlarmManager()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State var alarm: Alarm = Alarm(alarm: Date())
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var setDate: SetupDate
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Based on your \(willGoToSleep ? "bedtime" : "wake up time") of")
                    Text(userSetBedtime.hourMinAlarm)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Text("You should \(willGoToSleep ? "wake up" : "go to sleep") at:")
                    
                } //Intro Text + Goal Time
                Spacer()
                List {
                    ForEach(alarms.indices, id: \.self) { index in
                        Text(alarms[index].hourMinAlarm)
                            .foregroundColor(listTextColor(index, sleepWake))
                            .onTapGesture {
                                if sleepWake == .wakeUp {
                                    alarm = userSetBedtime
                                } else {
                                    alarm = alarms[index]
                                }
                                showingAlert = true
                                alertTitle = "Set Alarm"
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .font(.system(size: 40))
                .fontWeight(.bold)
            } //Total Content
            .padding(30)
            .alert(alertTitle, isPresented: $showingAlert) {
                
                Button("Cancel", role: .cancel) {
                    showingAlert = false
                }
                // instead of NavigationLink, you would set your navigationPath = [.alarm]
//                NavigationLink("Set Alarm", destination: AlarmView(alarm: alarm))
                Button("Save Alarm") {
                    AlarmManager.shared.currentAlarm = alarm
                    let alarmWasSet = Date.now
                    AlarmManager.shared.alarmStartTime = Date.now
                    print("\(AlarmManager.shared.alarmStartTime)")
                    AlarmManager.shared.saveData()
                    
                    dismiss()
                    //Set @published variable to specify when the alarm was set
                    //date.now -> Save that to alarmManager too
                    //
                    
                }
                    // might also need to
                    // navigationPath = []
            } message: {
                Text("Would you like to set an alarm for \(alarm.hourMinAlarm)?")
            }
            
        }
    }
    
    func listTextColor(_ listNumber: Int, _ sleepWake: SleepWake) -> Color {
        let wakeUpHours = hoursBetweenAlarmAndNow(alarms[listNumber].alarm, userSetBedtime.alarm)
        let sleepHours = hoursBetweenAlarmAndNow(userSetBedtime.alarm, alarms[listNumber].alarm)
        switch sleepWake {
        case .wakeUp:
            if wakeUpHours >= 7 {
                return Color(colors.green)
            } else if wakeUpHours < 7 && wakeUpHours > 3 {
                return Color(colors.yellow)
            } else {
                return Color(colors.red)
            }
        case .goToSleep:
            if sleepHours >= 7 {
                return Color(colors.green)
            } else if sleepHours < 7 && sleepHours >= 4 {
                return Color(colors.yellow)
            } else {
                return Color(colors.red)
            }
        }
    }
    private func hoursBetweenAlarmAndNow(_ alarmTime: Date, _ now: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: alarmTime, to: now)
        if let hours = components.hour {
            return hours
        }
        return -1
    }
    
    private func generateMorningAlarms(_ setTime: Date) -> [Alarm] {
        //sleep cycle Info Here
        //figure ou t90 minute cycles going from the timeSet
        let calendar = Calendar.current
        
        var myAlarms: [Alarm] = []
        var bedtime = calendar.date(byAdding: .minute, value: 90, to: setTime)!
        for _ in 0...5 {
            bedtime = calendar.date(byAdding: .minute, value: 90, to: bedtime) ?? Date()
            myAlarms.append(Alarm(alarm: bedtime))
        }
        return myAlarms
    }
    
    private func generateEveningAlarms(_ setTime: Date) -> [Alarm] {
        //Sleep Cycle Info HERE
        let calendar = Calendar.current
        
        var myAlarms: [Alarm] = []
        var bedtime = calendar.date(byAdding: .minute, value: -90, to: setTime)!
        for _ in 0...5 {
            bedtime = calendar.date(byAdding: .minute, value: -90, to: bedtime) ?? Date()
            myAlarms.append(Alarm(alarm: bedtime))
        }
        
//        return myAlarms.reversed()
//        let testAlarms: [Alarm] = [Alarm(alarm: calendar.date(byAdding: .minute, value: 60, to: setTime)!)]
        return myAlarms
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(sleepWake: SleepWake.goToSleep, userSetBedtime: Alarm(alarm: Date()))
    }
}
