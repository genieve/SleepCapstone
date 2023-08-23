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
    
    func save() {
        
    }
    
    init() {
         currentAlarm = loadAlarm()
    }
    func loadAlarm() -> Alarm? {
        nil
    }
}
