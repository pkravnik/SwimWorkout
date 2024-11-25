//
//  WorkoutSegment.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation

struct WorkoutSegment: Identifiable, Hashable {
    let id = UUID()
    let segmentNo: Int
    let startDate: Date
    let endDate: Date
    let laps: [WorkoutLap]
}

extension WorkoutSegment: WorkoutStatistic {
    var distanceInMeters: Double {
        laps.compactMap(\.distanceInMeters).reduce(0, +)
    }
    
    var strokeCounts: [Int] {
        laps.compactMap(\.strokeCount)
    }
    
    var swimmingDurationInSeconds: TimeInterval {
        laps.map(\.swimmingDurationInSeconds).reduce(0, +)
    }
}

extension WorkoutSegment: Codable {
    enum CodingKeys: CodingKey {
        case segmentNo
        case startDate
        case endDate
        case laps
    }
}
