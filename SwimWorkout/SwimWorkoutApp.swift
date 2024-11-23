//
//  SwimWorkoutApp.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 17.11.2024.
//

import SwiftUI
import HealthKit
import HealthKitUI

let healthDataTypes: Set = [
    HKQuantityType.workoutType(),
    HKQuantityType(.distanceSwimming),
    HKQuantityType(.swimmingStrokeCount),
    HKQuantityType(.heartRate)
]

let store = HKHealthStore()

@main
struct SwimWorkoutApp: App {
    @State private var authenticated = false
    @State private var trigger = false
    @State var workoutStore = WorkoutStore()
    var body: some Scene {
        WindowGroup {
            WorkoutList()
                .healthDataAccessRequest(store: store, readTypes: healthDataTypes, trigger: trigger) { result in
                    switch result {
                    case .success(_):
                        workoutStore.healthStorePermissionsGranted()
                    case .failure(let error):
                        fatalError("*** An error occurred while requesting authentication: \(error) ***")
                    }
//                    logger.debug("Authentication Complete.")
                }
                .onAppear {
                    trigger.toggle()
                }
                .environment(workoutStore)
        }
    }
}
