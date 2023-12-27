//
//  ChoseExerciseViewModel.swift
//  TESCIK
//
//  Created by Kuba on 22/12/2023.
//

import Foundation
import RealmSwift

class ChooseExerciseViewModel: ObservableObject {
    @Published var dateOfTraining = Date()
    @Published var exerciseToSetsMap: [Exercise: [SetsModel]] = [:]

    private let realmService: RealmServiceProtocol

    init(realmService: RealmServiceProtocol = RealmService()) {
        self.realmService = realmService
    }

    func saveTraining(with exerciseToSetsMap: [Exercise: [SetsModel]], completion: @escaping (Result<Void, Error>) -> Void) {
        let newTrainingSession = TrainingSession()
        newTrainingSession.date = dateOfTraining

        for (exercise, sets) in exerciseToSetsMap {
            let exerciseSet = ExerciseSet()
            exerciseSet.exercise = exercise
            exerciseSet.sets.append(objectsIn: sets)
            newTrainingSession.exerciseSets.append(exerciseSet)
        }

        realmService.save(newTrainingSession, completion: completion)
    }
}

