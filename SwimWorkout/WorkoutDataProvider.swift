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
            var segmentNo = 0
            let segments = hkWorkout.segments.map { hkEventSegment in
                var lapNo = 0
                let laps = hkWorkout.laps(for: hkEventSegment).map { hkEventLap in
                    lapNo += 1
                    return WorkoutLap(lapNo: lapNo, startDate: hkEventLap.dateInterval.start, endDate: hkEventLap.dateInterval.end, strokeCount: nil, distanceInMeters: 0)
                }
                segmentNo += 1
                return WorkoutSegment(segmentNo: segmentNo, startDate: hkEventSegment.dateInterval.start, endDate: hkEventSegment.dateInterval.end, laps: laps)
            }
            return Workout(startDate: hkWorkout.startDate, endDate: hkWorkout.endDate, lapLengthInMeters: hkWorkout.lapLengthInMeters, swimmingLocationType: hkWorkout.swimmingLocationType, kilocalories: nil, segments: segments)
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
