//
//  HKWorkout+Events.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 30.11.2024.
//

import HealthKit

extension HKWorkout {
    var segments: [HKWorkoutEvent] {
        guard let workoutEvents else { return [] }
        return workoutEvents.filter { $0.type == .segment }
    }
    
    func laps(for segment: HKWorkoutEvent) -> [HKWorkoutEvent] {
        guard let workoutEvents else { return [] }
        return workoutEvents.filter { $0.type == .lap && $0.dateInterval.start >= segment.dateInterval.start && $0.dateInterval.end <= segment.dateInterval.end }
    }
}
