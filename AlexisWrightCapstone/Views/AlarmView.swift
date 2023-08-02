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
    
    var body: some View {
        ZStack {
            VStack {
                TimelineView(.animation) { context in
                    
                    let value = timeRemaining(for: context.date) //Pass in Time Remaining into the Alarm Value
                    
                    ZStack {
                        Circle()
                            .stroke(
                                Color(colors.darkBlue), lineWidth: 30)
                        Circle()
                            .trim(from: value, to: 1)
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
