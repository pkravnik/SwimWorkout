//
//  WorkoutDataProvider.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation
import HealthKit

struct WorkoutDataProvider {
    var fetchWorkouts: () async throws -> [Workout]
    
    struct Failure: Error, Equatable {}
}

extension WorkoutDataProvider {
    static var live = Self(fetchWorkouts: {
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.workout(HKQuery.predicateForWorkouts(with: .swimming))],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
            limit: 20)
        let hkWorkouts = try await descriptor.result(for: store)
        let workouts: [Workout] = hkWorkouts.map { hkWorkout in
            Workout(startDate: hkWorkout.startDate, endDate: hkWorkout.endDate, lapLengthInMeters: nil, swimmingLocationType: .pool, kilocalories: nil, segments: [])
        }
//        let workouts = try await hkWorkouts.asyncMap { workout in
//            let laps = try await fetchLaps(for: workout)
//            let segments = workout.workoutEvents?.map { workoutEvent in
//                WorkoutSegment(segmentNo: 1, duration: workoutEvent.dateInterval.duration, type: workoutEvent.type.workoutSegmentType)
//            }
//            return Workout(startDate: workout.startDate, endDate: workout.endDate, lapLengthInMeters: workout.lapLengthInMeters, swimmingLocationType: .unknown, laps: laps, segments: segments ?? [])
//        }
        return workouts
    })
}
