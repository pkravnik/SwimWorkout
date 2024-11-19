//
//  Workout+Sample.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import Foundation

extension Workout {
    static var sample: [Workout] {
        let dates: [Date: Int] = [
            Date.now : 45,
            Calendar.current.date(byAdding: .day, value: -1, to: Date.now)! : 41,
            Calendar.current.date(byAdding: .day, value: 1, to: Date.now)! : 52
        ]
        return dates.map { (date, minutes) in
            Workout(startDate: date, endDate: Calendar.current.date(byAdding: .minute, value: minutes, to: date)!, lapLengthInMeters: nil, swimmingLocationType: .pool, segments: [])
        }
    }
}
