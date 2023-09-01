//
//  Colors.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/31/23.
//

import SwiftUI

struct Colors {
    let background = CGColor(red: 0.050980392156862744, green: 0.023529411764705882, blue: 0.18823529411764706, alpha: 1)
    let darkBlue = CGColor(red: 0.09411764705882353, green: 0.19215686274509805, blue: 0.30980392156862746, alpha: 1)
    let lightBlue = CGColor(red: 0.2196078431372549, green: 0.3058823529411765, blue: 0.4666666666666667, alpha: 1)
    let teal = CGColor(red: 0.5450980392156862, green: 0.7450980392156863, blue: 0.6980392156862745, alpha: 1)
    let text = CGColor(red: 0.9019607843137255, green: 0.9764705882352941, blue: 0.6862745098039216, alpha: 1)
    
    let green = CGColor(red: 0.592156862745098, green: 0.8588235294117647, blue: 0.30980392156862746, alpha: 1)
    let yellow = CGColor(red: 0.9921568627450981, green: 0.9058823529411765, blue: 0.2980392156862745, alpha: 1)
    let red = CGColor(red: 0.749, green: 0.149, blue: 0.231, alpha: 1)
    
    func alarmListColor(_ listNumber: Int) -> CGColor {
        if listNumber >= 0 && listNumber <= 2 {
            return green
        } else if listNumber > 2 && listNumber <= 4 {
            return yellow
        }
        return red
    }
}
