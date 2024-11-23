//
//  WorkoutCell.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import SwiftUI

struct WorkoutCell: View {
    let workout: Workout
    var body: some View {
        HStack {
            Text(workout.startDate, format: .dateTime)
            Spacer()
            Text(DateInterval(start: workout.startDate, end: workout.endDate).duration.formatted(.number))
        }
    }
}

#Preview(traits: .listEmbedded) {
    WorkoutCell(workout: Workout.sample[0])
}
