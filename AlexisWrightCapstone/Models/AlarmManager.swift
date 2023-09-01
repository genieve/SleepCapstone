//
//  AlarmManager.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/17/23.
//

import Foundation

class AlarmManager: ObservableObject {
    static let shared = AlarmManager()
    
    @Published var currentAlarm: Alarm?
    @Published var alarmStartTime: Date?
    @Published var timelineContext: Double?
    var alarmPassed: Bool? {
        currentAlarm?.alarm.timeIntervalSince1970 ?? 0 < Date().timeIntervalSince1970
    }
    
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("alarms").appendingPathExtension("plist")
    
//    var alarmPassed: Bool {
//        alarm.alarm.timeIntervalSince1970 < Date().timeIntervalSince1970
//    }
    
    func saveData() {
        let plistEncoder = PropertyListEncoder()
        let codedAlarm = try? plistEncoder.encode(currentAlarm)
        let codedStartTime = try? plistEncoder.encode(alarmStartTime)
        let codedTimelineContext = try? plistEncoder.encode(timelineContext)
        
        try? codedAlarm?.write(to: AlarmManager.archiveURL, options: .noFileProtection)
        try? codedStartTime?.write(to: AlarmManager.archiveURL, options: .noFileProtection)
        try? codedTimelineContext?.write(to: AlarmManager.archiveURL, options: .noFileProtection)
    }
    
    init() {
        currentAlarm = loadAlarm()
        alarmStartTime = loadStartTime()
        print(alarmStartTime)
        timelineContext = loadTimelinecontext()
    }
    
    func loadAlarm() -> Alarm? {
        guard let codedAlarm = try? Data(contentsOf: AlarmManager.archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Alarm.self, from: codedAlarm)
    }
    
    func loadStartTime() -> Date? {
        guard let codedStartTime = try? Data(contentsOf: AlarmManager.archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Date.self, from: codedStartTime)
    }
    
    func loadTimelinecontext() -> Double? {
        guard let codedTimelineContext = try? Data(contentsOf: AlarmManager.archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Double.self, from: codedTimelineContext)
    }
}
