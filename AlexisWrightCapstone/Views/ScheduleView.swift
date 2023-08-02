//
//  ContentView.swift
//  AlexisWrightCapstone
//
//  Created by Alexis Wright on 7/25/23.
//

import SwiftUI

enum SleepWake: CaseIterable, Identifiable {
    case goToSleep
    case wakeUp
    var id: Self { self }
    
    var description: String {
        switch self {
        case .wakeUp:
            return "Wake Up"
        case .goToSleep:
            return "Go To Sleep"
        }
    }
}
enum AppView: Codable, Hashable{
    case scheduleView(Date)
    case timeView(Date)
    case alarmView(Date)
}

struct ScheduleView: View {
    let colors = Colors()
    
    @State private var sleepTime: Alarm = Alarm(alarm: Date())
    @State private var sleepOrWake: SleepWake = .goToSleep
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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
                    Button(action: {
                        print("Go Button Link")
                    }, label: {
                        NavigationLink(destination: TimeView(sleepWake: sleepOrWake, goalTime: sleepTime)) {
                            Text("Go")
                        }
                    })
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)
                }
                .padding(20)
            }//zstack for UI
        } //Navigation View
    }//Body
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
