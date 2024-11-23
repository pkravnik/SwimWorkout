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
            VStack(alignment: .leading) {
                Text(workout.startDate, format: Date.FormatStyle(date: .long))
                Text(workout.swimmingLocationType.title)
                optionalMeasurement(workout.lapLengthWithUnit)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Text(workout.startDate..<workout.endDate, format: .timeDuration)
                optionalMeasurement(workout.distanceWithUnit)
                optionalMeasurement(workout.caloriesWithUnit)
            }
        }
    }
    
    func optionalMeasurement<T: Dimension>(_ value: Measurement<T>?) -> some View {
        if let value {
            Text(value, format: .measurement(width: .abbreviated, usage: .asProvided))
        } else {
            Text("No data")
        }
    }
}

#Preview(traits: .listEmbedded) {
    WorkoutCell(workout: Workout.sample[0])
}
