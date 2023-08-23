//
//  Alarm.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/2/23.
//

import Foundation

struct Alarm: Codable, Hashable {
    var alarm: Date
    var hourMinAlarm: String {
        formatDateToStringHrMin(date: alarm)
    }
    
    private func formatDateToStringHrMin(date: Date) -> String {
        date.formatted(.dateTime.hour().minute())
    }
}
