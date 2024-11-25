//
//  WorkoutSegmentDetail.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 24.11.2024.
//

import SwiftUI

struct WorkoutSegmentDetail: View {
    let segment: WorkoutSegment
    var body: some View {
        Form {
            Section("Segment \(segment.segmentNo)") {
                LabeledContent("Duration", value: segment.duration, format: .timeDuration)
                LabeledContent("Swimming Time", value: segment.swimmingDuration, format: .timeDuration)
                LabeledContent("Distance", value: segment.distanceWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided))
                LabeledContent("Average speed", value: segment.averageSpeedWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(1))))
                LabeledContent("Average stokes") {
                    if let strokes = segment.averageStrokeCount {
                        Text("\(strokes, specifier: "%.1f") strokes")
                    } else {
                        Text("Unknown")
                    }
                }
            }
            
            Section("Laps") {
                List {
                    ForEach(segment.laps) { lap in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "point.forward.to.point.capsulepath")
                                    Text("Lap \(lap.lapNo)")
                                }
                                HStack {
                                    Image(systemName: "stopwatch")
                                    Text(lap.duration, format: .timeDuration)
                                }
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(lap.distanceWithUnit, format: .measurement(width: .abbreviated, usage: .asProvided))
                                Text(lap.strokeCount != nil ? "\(lap.strokeCount!) stroke" : "Unknown")
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview(traits: .navEmbedded) {
    WorkoutSegmentDetail(segment: Workout.sample[0].segments[0])
}
