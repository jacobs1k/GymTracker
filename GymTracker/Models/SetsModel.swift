//
//  SetsModel.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import Foundation
import RealmSwift

class SetsModel: Object {
    @Persisted var sets: Int = 0
    @Persisted var repetitions: Int = 0
    @Persisted var weight: Double = 0.0
    
    convenience init(sets: Int, repetitions: Int, weight: Double) {
        self.init()
        self.sets = sets
        self.repetitions = repetitions
        self.weight = weight
    }
}
