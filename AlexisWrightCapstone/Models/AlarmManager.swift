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
    
    var alarmPassed: Bool? {
        currentAlarm?.alarm.timeIntervalSince1970 ?? 0 < Date().timeIntervalSince1970
    }
    

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let alarmURL = documentsDirectory.appendingPathComponent("alarms").appendingPathExtension("plist")
    static let startTimeURL = documentsDirectory.appendingPathComponent("startTime").appendingPathExtension("plist")

    
    func saveData() {
        let plistEncoder = PropertyListEncoder()
        
        let codedAlarm = try? plistEncoder.encode(currentAlarm)
        let codedStartTime = try? plistEncoder.encode([alarmStartTime])
        
//        print("codedALarm: \(codedAlarm)")
//        print("startTime: \(alarmStartTime)")
//
//        print("startTime after doCatch: \(alarmStartTime)")
        
        try? codedStartTime?.write(to: AlarmManager.startTimeURL, options: .noFileProtection)
        try? codedAlarm?.write(to: AlarmManager.alarmURL, options: .noFileProtection)
    }
    
    init() {
        currentAlarm = loadAlarm()
        alarmStartTime = loadStartTime()
//        print("alarmStartTime: \(alarmStartTime)")
//        timelineContext = loadTimelinecontext()
    }
    
    func loadAlarm() -> Alarm? {
        guard let codedAlarm = try? Data(contentsOf: AlarmManager.alarmURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Alarm.self, from: codedAlarm)
    }
    
    func loadStartTime() -> Date? {
        do {
            let codedStartTime = try Data(contentsOf: AlarmManager.startTimeURL)
            let propertyListDecoder = PropertyListDecoder()
            
//            print("LoadCodedStartTime: \(codedStartTime)")
            
            let array = try? propertyListDecoder.decode([Date].self, from: codedStartTime)
            return array?.first
        } catch {
            print(error)
        }
//        guard let codedStartTime =  else { return nil }
        return nil
    }
    
}


/*       if let codedAlarm = try? plistEncoder.encode(currentAlarm) {
 print("coded Alarm: \(codedAlarm)")
 try? codedAlarm.write(to: AlarmManager.alarmURL, options: .noFileProtection)
}
if let alarmStartTime {
 print("alarm startTime \(alarmStartTime)")
 do {
     let codedStartTime = try? plistEncoder.encode(alarmStartTime)
     print("coded StartTime: \(codedStartTime)")
     try? codedStartTime?.write(to: AlarmManager.startTimeURL, options: .noFileProtection)
 } catch {
     print("Error handling alarmStartTime: \(error)")
 }
 */
