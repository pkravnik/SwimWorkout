//
//  WorkoutStore.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 18.11.2024.
//

import SwiftUI
import OSLog

@Observable
final class WorkoutStore {
    enum LoadingState {
        case loading
        case loaded(result: [Workout])
        case empty
        case error(message: String)
    }
    
    private let dataProvider: WorkoutDataProvider
    var loadingState: LoadingState = .loading
    
    init(dataProvider: WorkoutDataProvider = .live) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    func fetchWorkouts() async {
        loadingState = .loading
        Logger.fetchingWorkouts.debug("Started fetching workouts.")
        
        do {
            let fetchedWorkouts = try await dataProvider.fetchWorkouts()
            loadingState = fetchedWorkouts.isEmpty ? .empty : .loaded(result: fetchedWorkouts)
        } catch {
            loadingState = .error(message: error.localizedDescription)
            Logger.fetchingWorkouts.error("Error fetching workouts: \(error.localizedDescription).")
        }
    }
}
