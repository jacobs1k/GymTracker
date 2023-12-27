//
//  ProfileViewModel.swift
//  TESCIK
//
//  Created by Kuba on 24/12/2023.
//

import Foundation
import RealmSwift

struct ExerciseProgress: Identifiable{
    let id: UUID = UUID() 
    var date: Date
    var totalWeight: Double
}

class ProfileViewModel: ObservableObject {
    @Published var progressData: [ExerciseProgress] = []

    func fetchProgress(for exerciseName: String) {
        let realm = try! Realm() // Replace with safe error handling
        let sessions = realm.objects(TrainingSession.self)

        var progress: [ExerciseProgress] = []
        for session in sessions {
            let date = session.date
            var totalWeight: Double = 0

            for exerciseSet in session.exerciseSets where exerciseSet.exercise?.name == exerciseName {
                for set in exerciseSet.sets {
                    totalWeight += Double(set.repetitions) * set.weight
                }
            }

            if totalWeight > 0 {
                progress.append(ExerciseProgress(date: date, totalWeight: totalWeight))
            }
        }

        self.progressData = progress.sorted { $0.date < $1.date } // Sort by date
    }
}

