//
//  ExerciseSet.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import Foundation
import RealmSwift



class ExerciseSet: Object {
    @Persisted var exercise: Exercise?
    @Persisted var sets: List<SetsModel>
    
    convenience init(exercise: Exercise, sets: List<SetsModel>) {
        self.init()
        self.exercise = exercise
        self.sets = sets
    }
}


