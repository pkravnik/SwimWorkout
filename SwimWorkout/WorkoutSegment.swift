//
//  WorkoutSegment.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation

struct WorkoutSegment: Identifiable {
    let id = UUID()
    let duration: TimeInterval
    let laps: [WorkoutLap]
}
