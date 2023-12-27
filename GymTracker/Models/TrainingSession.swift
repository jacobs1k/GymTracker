//
//  TrainingSession.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import Foundation
import RealmSwift

class TrainingSession: Object {
    @Persisted var date: Date = Date()
    @Persisted var exerciseSets: List<ExerciseSet>
}
