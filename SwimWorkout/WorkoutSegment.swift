//
//  WorkoutSegment.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation

struct WorkoutSegment: Identifiable, Hashable, Codable {
    let id = UUID()
    let duration: TimeInterval
    let laps: [WorkoutLap]
    
    enum CodingKeys: CodingKey {
        case duration
        case laps
    }
}
