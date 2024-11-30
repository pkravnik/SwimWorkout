//
//  Workout+Sample.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import Foundation
import HealthKit

extension Workout {
    static var sample: [Workout] {
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let workouts = try? decoder.decode([Workout].self, from: data) else { return [] }
        return workouts
    }
    
    static var sampleMock: [Workout] {
        guard let url = Bundle.main.url(forResource: "Mock", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let workoutsI = try? decoder.decode([ImportModel.Workout].self, from: data) else { return [] }
        
        let workouts = workoutsI.map { workoutI in
            let samples = workoutI.samples
            let samplesMerged = samples.grouped { sample in
                sample.split
            }
            var segmentNo = 0
            let segments = workoutI.segments.map { segmentI in
                var lapNo = 0
                let laps = workoutI.laps(for: segmentI).map { lapI in
                    lapNo += 1
                    let strokeCount = samplesMerged[lapI.sampleKeySwimmingStrokeCount, default: nil]
                    let distanceInMeters: Double = samplesMerged[lapI.sampleKeyDistanceSwimming, default: nil] ?? .zero
                    return WorkoutLap(lapNo: lapNo, startDate: lapI.startDate, endDate: lapI.endDate, strokeCount: strokeCount.map { Int($0) }, distanceInMeters: distanceInMeters)
                }
                segmentNo += 1
                return WorkoutSegment(segmentNo: segmentNo, startDate: segmentI.startDate, endDate: segmentI.endDate, laps: laps)
            }
            
            return Workout(startDate: workoutI.startDate, endDate: workoutI.endDate, lapLengthInMeters: workoutI.lapLength, swimmingLocationType: workoutI.swimmingLocationType, kilocalories: nil, segments: segments)
        }
        return workouts
    }
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
}
