//
//  TimeRemaining.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/28/23.
//

import Foundation

struct AlarmTimeRemaining {
    let alarmStart: Date
    let alarmEnd: Date
    
    var hours: Int {
        hoursInAlarm(for: alarmStart, alarmEnd)
    }
    var minutes: Int {
        minutesInAlarm(for: alarmStart, alarmEnd)
    }
    var seconds: Int {
        secondsInAlarm(for: alarmStart, alarmEnd)
    }
    
    private func hoursInAlarm(for startDate: Date, _ endDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: startDate, to: endDate)
        if let hours = components.hour {
            return hours
        }
        return -1
    }
    private func minutesInAlarm(for startDate: Date, _ endDate: Date) -> Int {
        let diffComponents = Calendar.current.dateComponents([ .minute], from: startDate, to: endDate)
        if let minutes = diffComponents.minute {
            return minutes % 60
        }
        return -1
    }
    private func secondsInAlarm(for startDate: Date, _ endDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.minute, .second], from: startDate, to: endDate)
        if let seconds = components.second {
            return seconds
        }
        return -1
    }
}
