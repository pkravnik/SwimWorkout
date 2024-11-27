//
//  Workout+Sample.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import Foundation

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
            Workout(startDate: workoutI.startDate, endDate: workoutI.endDate, lapLengthInMeters: workoutI.lapLength, swimmingLocationType: workoutI.swimmingLocationType, kilocalories: nil, segments: [])
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
