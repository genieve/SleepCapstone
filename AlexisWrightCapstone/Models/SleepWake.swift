//
//  SleepWake.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/17/23.
//

import Foundation

enum SleepWake: Codable, Hashable, CaseIterable, Identifiable {
    case goToSleep
    case wakeUp
    case wakeUpBefore
    var id: Self { self }
    
    var description: String {
        switch self {
        case .wakeUp:
            return "Wake Up"
        case .goToSleep:
            return "Go To Sleep"
        case .wakeUpBefore:
            return "Wake Up Before"
        }
    }
}
