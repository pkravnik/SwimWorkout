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
        case notStarted
        case loading
        case loaded(result: [Workout])
        case empty
        case error(message: String)
    }
    
    private let dataProvider: WorkoutDataProvider
    private(set) var loadingState: LoadingState = .notStarted
    
    init(dataProvider: WorkoutDataProvider = .live, loadingState: LoadingState = .notStarted) {
        self.dataProvider = dataProvider
        self.loadingState = loadingState
    }
    
    public func healthStorePermissionsGranted() {
        loadingState = .loading
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
