//
//  WorkoutSampleKey.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 30.11.2024.
//

import Foundation
import HealthKit

struct WorkoutSampleKey: Hashable {
    var startDate: Date
    var endDate: Date
    var quantityType: String
}

extension HKWorkoutEvent {
    var sampleKeyDistanceSwimming: WorkoutSampleKey {
        WorkoutSampleKey(startDate: self.dateInterval.start, endDate: self.dateInterval.end, quantityType: HKQuantityTypeIdentifier.distanceSwimming.rawValue)
    }
    
    var sampleKeySwimmingStrokeCount: WorkoutSampleKey {
        WorkoutSampleKey(startDate: self.dateInterval.start, endDate: self.dateInterval.end, quantityType: HKQuantityTypeIdentifier.swimmingStrokeCount.rawValue)
    }
}

extension HKQuantitySample {
    var value: Double? {
        switch self.quantityType.identifier {
        case HKQuantityTypeIdentifier.swimmingStrokeCount.rawValue: return self.quantity.doubleValue(for: .count())
        case HKQuantityTypeIdentifier.distanceSwimming.rawValue: return self.quantity.doubleValue(for: .meter())
        default: return nil
        }
    }
    
    var sampleKey: WorkoutSampleKey {
        WorkoutSampleKey(startDate: self.startDate, endDate: self.endDate, quantityType: self.quantityType.identifier)
    }
    
    var split: (WorkoutSampleKey, Double?) {
        (self.sampleKey, self.value)
    }
}
