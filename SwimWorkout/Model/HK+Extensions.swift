//
//  HK+Extensions.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 27.11.2024.
//

import Foundation
import HealthKit

extension HKWorkoutSwimmingLocationType {
    var title: String {
        switch self {
        case .openWater: return "Open water"
        case .pool: return "Pool"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown location"
        }
    }
}
