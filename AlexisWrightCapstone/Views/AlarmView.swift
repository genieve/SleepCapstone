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
    
    @State private var sleepTime: Alarm = Alarm(alarm: Date())
    @State private var sleepOrWake: SleepWake = .goToSleep
    
    
    var body: some View {
        ZStack {
            VStack { //Whole view, padding is here
                VStack { //upper group of text
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
                TimelineView(.animation) { context in
                    
                    let value = timeRemaining(for: context.date) //Pass in Time Remaining into the Alarm Value
                    
                    ZStack {
                        Circle()
                            .stroke(
                                Color(colors.darkBlue), lineWidth: 30)
                        Circle()
                            .trim(from: value, to: 2)
                            .stroke(
                                Color(colors.teal),
                                style: StrokeStyle(lineWidth: 30, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .scaleEffect(x: -1, y: 1)
                        VStack {
                            Text("Alarm will go off at")
                            Text(alarm.hourMinAlarm)
                                .font(.system(size: 30))
                        } // VStack
                    } //Alarm Circles
                } //timeline view
            } //vstack
            .padding(75)
            .cornerRadius(20)
        }
    }
    
    private func timeRemaining(for date: Date) -> Double {
        //return timeRemaining
        //the time remaining is the difference between the current date and the alarm that's set.
        //the alarm will always be in the future
        //SO
//        let minutes = alarm.alarm.minutes(from: date)
//        if minutes > 60  {
//            return Double(minutes)
//        } else {
//            let seconds = alarm.alarm.seconds(from: date)
//            return Double(seconds) / 60
//        }
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 60
    }
    
    private func formatDateToStringHrMin(date: Date) -> String {
        return date.formatted(.dateTime.hour().minute())
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(alarm: Alarm(alarm: Date()))
    }
}
