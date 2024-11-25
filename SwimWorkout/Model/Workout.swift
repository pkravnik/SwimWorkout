//
//  Workout.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 17.11.2024.
//

import Foundation

struct Workout: Identifiable, Hashable {
    enum SwimmingLocationType: String, Codable {
        case openWater
        case pool
        case unknown
        
        var title: String {
            switch self {
            case .openWater: return "Open water"
            case .pool: return "Pool"
            case .unknown: return "Unknown"
            }
        }
    }
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let lapLengthInMeters: Double?
    let swimmingLocationType: SwimmingLocationType
    let kilocalories: Double?
    let segments: [WorkoutSegment]
    
    var lapLengthWithUnit: Measurement<UnitLength>? {
        lapLengthInMeters.map { Measurement(value: $0, unit: .meters)}
    }
    
    var caloriesWithUnit: Measurement<UnitEnergy>? {
        kilocalories.map { Measurement(value: $0, unit: .kilocalories)}
    }
}

extension Workout: WorkoutStatistic {
    var distanceInMeters: Double {
        segments.map(\.distanceInMeters).reduce(0, +)
    }
    
    var strokeCounts: [Int] {
        segments.flatMap(\.strokeCounts)
    }
    
    var swimmingDurationInSeconds: TimeInterval {
        segments.map(\.swimmingDurationInSeconds).reduce(0, +)
    }
}

extension Workout: Codable {
    enum CodingKeys: CodingKey {
        case startDate
        case endDate
        case lapLengthInMeters
        case swimmingLocationType
        case kilocalories
        case segments
    }
}
