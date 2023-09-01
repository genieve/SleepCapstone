//
//  AlarmView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/31/23.
//

import SwiftUI

struct AlarmView: View {
    let colors = Colors()
    var alarm: Alarm //Pass in the correct Alarm Time
    
    var alarmPassed: Bool {
        alarm.alarm.timeIntervalSince1970 < Date().timeIntervalSince1970
    }
    
    @State private var isBlinking = false
    @State private var sleepTime: Alarm = Alarm(alarm: Date())
    @State private var sleepOrWake: SleepWake = .goToSleep
    
    @State private var startedBlinking = false
    
    
    
    var body: some View {
        ZStack {
            VStack { //Whole view, padding is here
                VStack { //upper group of text
                    //MARK: Schedule View Part Two Electric Boogaloo
                    VStack {
                        Text("I want to ")
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
                            .font(.system(size: 32))
                    } //nav link
                } //Vstack
                .padding(20)
                
                // MARK: Timeline View
                TimelineView(.animation) { context in
                    
                    let value = timeRemaining(for: context.date) //Pass in Time Remaining into the Alarm Value
                    let alarmTimeRemaining = AlarmTimeRemaining(alarmStart: context.date, alarmEnd: alarm.alarm)
                    
                    let startTime = AlarmManager.shared.alarmStartTime?.timeIntervalSince1970
                    
                    
                    ZStack {
                        Circle()
                            .stroke(
                                Color(colors.darkBlue), lineWidth: 30)
                        Circle()
                        //MARK: Countdown Circle
                            .trim(from: 0, to: value)
                            .stroke(
                                Color(colors.teal),
                                style: StrokeStyle(lineWidth: 30, lineCap: .butt))
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            Text("Alarm \(alarmPassed ? "went off at": "will go off at")")
                            Text("\(value)")
                            Text("\(startTime?.description ?? "nil")")
                            Text(alarm.hourMinAlarm)
                                .font(.system(size: 30))
                            
                            //MARK: Formatting H stack
                            
                            HStack {
                                //IF STATEMENT
                                if alarmTimeRemaining.hours <= 0 { //if no more hours
                                    if alarmTimeRemaining.minutes <= 0 { //if no more minutes
                                        if alarmTimeRemaining.seconds < 0 { //if there's no more time in the alarm
                                            Text("")
                                        } else {
                                            Text("0")
                                                .padding(-10)
                                            Text(":")
                                                .opacity(isBlinking ? 0 : 1)
                                                .padding(-7)
                                            Text(String(format: "%02d", alarmTimeRemaining.seconds))
                                                .padding(-10)
                                        }
                                    } else {
                                        if alarmTimeRemaining.minutes > 10 {
                                            Text("\(alarmTimeRemaining.minutes)")
                                                .padding(-5)
                                            Text(":")
                                                .opacity(isBlinking ? 0 : 1)
                                                
                                            Text(String(format: "%02d", alarmTimeRemaining.seconds))
                                                .padding(-7)

                                        } else {
                                            Text("\(alarmTimeRemaining.minutes)")
                                                .padding(-10)
                                            Text(":")
                                                .opacity(isBlinking ? 0 : 1)
                                                .padding(-7)
                                            Text(String(format: "%02d", alarmTimeRemaining.seconds))
                                                .padding(-10)
                                        }
                                        
                                    }
                                } else {
                                    Text("\(alarmTimeRemaining.hours)")
                                        .padding(-8)
                                    Text(":")
                                        .opacity(isBlinking ? 0 : 1)
                                        .padding(-7)
                                    Text(String(format: "%02d", alarmTimeRemaining.minutes))
                                        .padding(-10)
                                }
                            }
                            .onAppear {
                                if !alarmPassed {
                                    startBlinking()
                                } else {
                                    isBlinking = false
                                }
                            }
                        } // VStack
                    } //Alarm Circles
                } //timeline view
            } //vstack
            .padding(75)
            .cornerRadius(20)
        }
    }
    //MARK: Time Remaining Function
    private func timeRemaining(for date: Date) -> Double {
        //return timeRemaining
        //the time remaining is the difference between the current date and the alarm that's set.
        //the alarm will always be in the future
        //SO
        //use timeintervalsince1970
        //do the END DATE - CURRENT DATE
        guard AlarmManager.shared.currentAlarm != nil else { return 0 }
        guard let startTime = AlarmManager.shared.alarmStartTime?.timeIntervalSince1970 else { return 1 } //coming back 0 if you exit the app
        
        let currentTime = Double(date.timeIntervalSince1970)
        let endTime = Double(alarm.alarm.timeIntervalSince1970)
        
        let alarmTimeRemaining = endTime - currentTime
        let totalAlarmTime = endTime - startTime
        
        let minutesLeftInAlarm = alarmTimeRemaining / 60
        let totalAlarmMinutes = totalAlarmTime / 60
        
        let result = minutesLeftInAlarm / totalAlarmMinutes
//        print("startTime: \(startTime)")
//        print("Current Time: \(currentTime)")
//        print("endTime: \(endTime)")
//        
        
        return result
    }
    
    private func startBlinking() {
        if !startedBlinking {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
                self.isBlinking.toggle()
            })
            startedBlinking = true
        }
    }
    
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(alarm: Alarm(alarm: Date()))
    }
}
