//
//  HasDuration.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 24.11.2024.
//

import Foundation

public protocol WorkoutStatistic {
    var startDate: Date { get }
    var endDate: Date { get }
    var distanceInMeters: Double { get }
    var strokeCounts: [Int] { get }
}

extension WorkoutStatistic {
    var duration: Range<Date> {
        startDate..<endDate
    }
    
    var durationInSeconds: TimeInterval {
        endDate.timeIntervalSince(startDate)
    }
    
    var distanceWithUnit: Measurement<UnitLength> {
        Measurement(value: distanceInMeters, unit: .meters)
    }
    
    var averageSpeedWithUnit: Measurement<UnitSpeed> {
        Measurement(value: (distanceInMeters / durationInSeconds) * 60.0, unit: .metersPerMinute)
    }
    
    var averageStrokeCount: Double? {
        guard strokeCounts.count > 0 else { return nil }
        return Double(strokeCounts.reduce(0, +)) / Double(strokeCounts.count)
    }
}
