//
//  WorkoutDataProvider+Test.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import Foundation

extension WorkoutDataProvider {
    static let testSuccess: Self = Self(
        fetchWorkouts: {
            try await Task.sleep(nanoseconds: 1000)
            return Workout.sampleMock
        }
    )
    
    static let testEmpty: Self = Self(
        fetchWorkouts: {
            try await Task.sleep(nanoseconds: 1000)
            return []
        }
    )
    
    static let testFailure: Self = Self(
        fetchWorkouts: {
            try await Task.sleep(nanoseconds: 1000)
            throw Failure()
        }
    )
    
    static let testLoading: Self = Self(
        fetchWorkouts: {
            try await Task.sleep(for: .seconds(5))
            return Workout.sample
        }
    )
}
