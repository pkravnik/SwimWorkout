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
    let lapLengthInMeters: Int?
    let swimmingLocationType: SwimmingLocationType
    let segments: [WorkoutSegment]
    
    enum CodingKeys: CodingKey {
        case startDate
        case endDate
        case lapLengthInMeters
        case swimmingLocationType
        case segments
    }
}
