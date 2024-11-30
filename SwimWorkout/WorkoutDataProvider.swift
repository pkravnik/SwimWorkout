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
    private static let descriptor = HKSampleQueryDescriptor(
        predicates: [.workout(HKQuery.predicateForWorkouts(with: .swimming))],
        sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
        limit: 20)
    
    static func swimmingSamplesDescriptor(for workout: HKWorkout) -> HKSampleQueryDescriptor<HKQuantitySample> {
        let forWorkout = HKQuery.predicateForObjects(from: workout)
        return HKSampleQueryDescriptor(
            predicates: [
                .quantitySample(type: HKQuantityType(.distanceSwimming), predicate: forWorkout),
                .quantitySample(type: HKQuantityType(.swimmingStrokeCount), predicate: forWorkout)
            ],
            sortDescriptors: [SortDescriptor(\.startDate, order: .forward)],
            limit: HKObjectQueryNoLimit)
    }
    
    
    static var live = Self(fetchWorkouts: {
        let hkWorkouts = try await descriptor.result(for: store)
        let workouts: [Workout] = try await hkWorkouts.asyncMap { hkWorkout in
            let samples = try await swimmingSamplesDescriptor(for: hkWorkout).result(for: store)
            let samplesMerged = samples.grouped { sample in
                sample.split
            }
            var segmentNo = 0
            let segments = hkWorkout.segments.map { hkEventSegment in
                var lapNo = 0
                let laps = hkWorkout.laps(for: hkEventSegment).map { hkEventLap in
                    lapNo += 1
                    let strokeCount = samplesMerged[hkEventLap.sampleKeySwimmingStrokeCount, default: nil]
                    let distanceInMeters = samplesMerged[hkEventLap.sampleKeyDistanceSwimming, default: nil] ?? .zero
                    return WorkoutLap(lapNo: lapNo, startDate: hkEventLap.dateInterval.start, endDate: hkEventLap.dateInterval.end, strokeCount: strokeCount.map { Int($0) }, distanceInMeters: distanceInMeters)
                }
                segmentNo += 1
                return WorkoutSegment(segmentNo: segmentNo, startDate: hkEventSegment.dateInterval.start, endDate: hkEventSegment.dateInterval.end, laps: laps)
            }
            return Workout(startDate: hkWorkout.startDate, endDate: hkWorkout.endDate, lapLengthInMeters: hkWorkout.lapLengthInMeters, swimmingLocationType: hkWorkout.swimmingLocationType, kilocalories: nil, segments: segments)
        }
        return workouts
    })
}
