//
//  WorkoutList.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 30.11.2024.
//

import SwiftUI

struct WorkoutList: View {
    let workouts: [Workout]
    var body: some View {
        List(workouts) { workout in
            NavigationLink(value: workout) {
                WorkoutCell(workout: workout)
            }
        }
        .listStyle(.plain)
        .accessibilityIdentifier("workoutList")
    }
}
