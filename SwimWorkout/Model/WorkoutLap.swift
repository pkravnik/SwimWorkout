//
//  WorkoutLap.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import Foundation

struct WorkoutLap: Identifiable, Hashable {
    let id = UUID()
    let lapNo: Int
    let startDate: Date
    let endDate: Date
    let strokeCount: Int?
    let distanceInMeters: Double
}

extension WorkoutLap: WorkoutStatistic {
    var strokeCounts: [Int] {
        guard let strokeCount else { return [] }
        return [strokeCount]
    }
}

extension WorkoutLap: Codable {
    enum CodingKeys: CodingKey {
        case lapNo
        case startDate
        case endDate
        case strokeCount
        case distanceInMeters
    }
}
