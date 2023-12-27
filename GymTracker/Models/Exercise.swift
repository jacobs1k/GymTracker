//
//  Exercise.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import Foundation
import RealmSwift

class Exercise: Object {
    @Persisted var name: String = ""
    @Persisted var whichBodyPart: String = ""
    
    var imageName: String {
            return "\(name.replacingOccurrences(of: " ", with: "_")).jpg"
        }
    
    convenience init(name: String, whichBodyPart: String) {
        self.init()
        self.name = name
        self.whichBodyPart = whichBodyPart
    }
}



