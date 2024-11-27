//
//  HKWorkout+Metadata.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 27.11.2024.
//

import Foundation
import HealthKit

extension HKWorkout {
    var averageMETs: HKQuantity? {
        return metadata?[HKMetadataKeyAverageMETs] as? HKQuantity
    }
    
    var lapLengthInMeters: Double? {
        guard let lapLength = metadata?[HKMetadataKeyLapLength] as? HKQuantity else { return nil }
        return lapLength.doubleValue(for: .meter())
    }
    
    var swimmingLocationType: HKWorkoutSwimmingLocationType {
        guard let swimmingLocationType = metadata?[HKMetadataKeySwimmingLocationType] as? Int else { return .unknown }
        return HKWorkoutSwimmingLocationType(rawValue: swimmingLocationType) ?? .unknown
    }
}

extension HKWorkout {
    var segments: [HKWorkoutEvent] {
        guard let workoutEvents else { return [] }
        return workoutEvents.filter { $0.type == .segment }
    }
}
