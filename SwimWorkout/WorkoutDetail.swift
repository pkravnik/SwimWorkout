//
//  WorkoutDetail.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 20.11.2024.
//

import SwiftUI

struct WorkoutDetail: View {
    let workout: Workout
    var body: some View {
        Form {
            Text(workout.startDate, format: .dateTime)
            Text(workout.endDate, format: .dateTime)
        }
        .navigationTitle(workout.startDate.formatted())
        .navigationBarTitleDisplayMode(.inline)
    }
}
