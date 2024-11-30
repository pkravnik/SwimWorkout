//
//  WorkoutList.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 19.11.2024.
//

import SwiftUI

struct WorkoutScreen: View {
    @Environment(WorkoutStore.self) private var workoutStore: WorkoutStore
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                switch workoutStore.loadingState {
                case .notStarted:
                    Text("Please give access to HealthKit data")
                case .loading:
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .accessibilityIdentifier("progressViewProductList")
                        .task {
                            await workoutStore.fetchWorkouts()
                        }
                case .empty:
                    ContentUnavailableView {
                        Label {
                            Text("No Workouts Found")
                        } icon: {
                            Image("question")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    } description : {
                        Text("More workouts will come soon")
                    } actions: {
                        Button {
                            Task {
                                await workoutStore.fetchWorkouts()
                            }
                        } label: {
                            Text("Retry")
                                .font(.title)
                        }
                    }
                case .loaded(let workouts):
                    VStack(alignment: .leading) {
                        CalendarView(date: .now, workouts: workouts) { day in
                            if let workout = workouts.first(where: {$0.startDate.startOfDay == day.startOfDay} ) {
                                navigationPath.append(workout)
                            }
                        }
                        Text("Latest Workouts:")
                            .font(.title3)
                            .padding(.leading)
                        WorkoutList(workouts: workouts)
                            .refreshable {
                                await workoutStore.fetchWorkouts()
                            }
                    }
                    
                case .error(let message):
                    ContentUnavailableView(
                        "There was a problem reaching the server. Please try again later.",
                        systemImage: "icloud.slash",
                        description: Text(message)
                    )
                }
            }
            .navigationTitle("Workouts")
            .navigationDestination(for: Workout.self) { workout in
                WorkoutDetail(workout: workout)
            }
            .navigationDestination(for: WorkoutSegment.self) { segment in
                WorkoutSegmentDetail(segment: segment)
            }
        }
    }
}

#Preview {
    WorkoutScreen()
        .environment(WorkoutStore(dataProvider: .testSuccess, loadingState: .loading))
}
