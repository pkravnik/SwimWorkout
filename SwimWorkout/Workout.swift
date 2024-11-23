//
//  Workout.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 17.11.2024.
//

import Foundation

struct Workout: Identifiable, Hashable, Codable {
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
    let distanceInMeters: Double?
    let kilocalories: Double?
    let segments: [WorkoutSegment]
    
    var distanceWithUnit: Measurement<UnitLength>? {
        distanceInMeters.map { Measurement(value: $0, unit: .meters) }
    }
    
    var lapLengthWithUnit: Measurement<UnitLength>? {
        lapLengthInMeters.map { Measurement(value: $0, unit: .meters)}
    }
    
    var caloriesWithUnit: Measurement<UnitEnergy>? {
        kilocalories.map { Measurement(value: $0, unit: .kilocalories)}
    }
    
    enum CodingKeys: CodingKey {
        case startDate
        case endDate
        case lapLengthInMeters
        case swimmingLocationType
        case distanceInMeters
        case kilocalories
        case segments
    }
}
