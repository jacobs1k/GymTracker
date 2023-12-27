//
//  Training.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import Foundation
import RealmSwift

class Training: Object {
    @Persisted var date: Date = Date()
    @Persisted var exercises: List<ExerciseSet>
}
