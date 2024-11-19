//
//  Logger+Extensions.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let fetchingWorkouts = Logger(subsystem: subsystem, category: "FetchingWorkouts")
}
