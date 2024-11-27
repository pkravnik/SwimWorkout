//
//  ImportModel.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 26.11.2024.
//

//
//  ExportModel.swift
//  MyWorkout
//
//  Created by Petr Kravnik on 25.11.2024.
//

import Foundation
import HealthKit

extension HKWorkoutSwimmingLocationType: Codable { }
extension HKWorkoutActivityType: Codable { }

enum ImportModel {
    struct Workout: Codable {
        let workoutActivityType: HKWorkoutActivityType // swimming - 46
        let startDate: Date
        let endDate: Date
        let averageMETs: Double // HKMetadataKeyAverageMETs
        let lapLength: Double // HKMetadataKeyLapLength
        let swimmingLocationType: HKWorkoutSwimmingLocationType // Key: HKMetadataKeySwimmingLocationType, Value: enum HKWorkoutSwimmingLocationType, case unknown = 0, case pool = 1, case openWater = 2
        let indoorWorkout: Bool // HKMetadataKeyIndoorWorkout
        let timeZone: String // HKMetadataKeyTimeZone
        let distanceSwimming: Double // HKQuantityTypeIdentifier.distanceSwimming
        let swimmingStrokeCount: Double // HKQuantityTypeIdentifier.swimmingStrokeCount
        let basalEnergyBurned: Double // HKQuantityTypeIdentifier.basalEnergyBurned
        let activeEnergyBurned: Double // HKQuantityTypeIdentifier.activeEnergyBurned
        let heartRate: Double // HKQuantityTypeIdentifier.heartRate
        let events: [WorkoutEvent]
        let samples: [QuantitySample]
    }
    
    struct WorkoutEvent: Codable {
        var type: Int // 7 - segment or 3 - lap
        var startDate: Date
        var endDate: Date
        var sWOLFScore: Double // HKMetadataKeySWOLFScore
    }
    
    struct QuantitySample: Codable {
        var startDate: Date
        var endDate: Date
        var key: String
        var value: Double
    }
}
