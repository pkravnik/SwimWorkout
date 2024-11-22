//
//  WorkoutLap.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation

struct WorkoutLap: Identifiable, Hashable, Codable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let strokeCount: Int?
    let lapLengthInMeters: Int?
    
    var strokeCountText: String {
        strokeCount?.description ?? "Unknown"
    }
    
    // TODO: Add Measurement formatter
    var distanceText: String {
        lapLengthInMeters?.description ?? "Unknown"
    }
    
    var duration: Range<Date> {
        startDate..<endDate
    }
    
    enum CodingKeys: CodingKey {
        case startDate
        case endDate
        case strokeCount
        case lapLengthInMeters
    }
}
