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
            Section("Workout details") {
                LabeledContent("Date", value: workout.startDate, format: Date.FormatStyle(date: .long))
                LabeledContent("Location", value: workout.swimmingLocationType.title)
                LabeledContent("Duration", value: workout.duration, format: .timeDuration)
//                optionalMeasurement(workout.lapLengthWithUnit)
//                optionalMeasurement(workout.distanceWithUnit)
//                optionalMeasurement(workout.caloriesWithUnit)
            }
            
            Section("Segments") {
                List {
                    ForEach(workout.segments) { segment in
                        NavigationLink(value: segment) {
                            VStack(alignment: .leading) {
                                Text("Segment \(segment.segmentNo)")
                                Text(segment.startDate..<segment.endDate, format: .timeDuration)
                                Text(segment.distanceWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(workout.startDate.formatted())
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .navEmbedded) {
    WorkoutDetail(workout: Workout.sample[0])
}
