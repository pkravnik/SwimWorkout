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
                LabeledContent("Swimming Time", value: workout.swimmingDuration, format: .timeDuration)
                LabeledContent("Distance", value: workout.distanceWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided))
                LabeledContent("Average speed", value: workout.averageSpeedWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(1))))
                LabeledContent("Average stokes") {
                    if let strokes = workout.averageStrokeCount {
                        Text("\(strokes, specifier: "%.1f") strokes")
                    } else {
                        Text("Unknown")
                    }
                }
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
