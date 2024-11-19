//
//  SwimWorkoutApp.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 17.11.2024.
//

import SwiftUI
import HealthKit

let store = HKHealthStore()

@main
struct SwimWorkoutApp: App {
    var body: some Scene {
        WindowGroup {
            WorkoutList()
        }
    }
}
