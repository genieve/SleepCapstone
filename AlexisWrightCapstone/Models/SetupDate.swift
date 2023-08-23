//
//  SetupDate.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 8/15/23.
//

import Foundation

class SetupDate: ObservableObject {
    @Published var setDate: Date
    
    init(date: Date) {
        self.setDate = date
    }
}
