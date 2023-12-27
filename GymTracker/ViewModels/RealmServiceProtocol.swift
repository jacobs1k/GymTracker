//
//  RealmServiceProtocol.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func save(_ trainingSession: TrainingSession, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchTrainingSessions(completion: @escaping (Result<[TrainingSession], Error>) -> Void)
    func deleteTrainingSession(_ session: TrainingSession, completion: @escaping (Result<Void, Error>) -> Void)
}


class RealmService: RealmServiceProtocol {
    func save(_ trainingSession: TrainingSession, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(trainingSession)
            }
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchTrainingSessions(completion: @escaping (Result<[TrainingSession], Error>) -> Void) {
           do {
               let realm = try Realm()
               let sessions = realm.objects(TrainingSession.self).sorted(byKeyPath: "date", ascending: false)
               completion(.success(Array(sessions)))
           } catch {
               completion(.failure(error))
           }
       }
    
    func deleteTrainingSession(_ session: TrainingSession, completion: @escaping (Result<Void, Error>) -> Void) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(session)
                }
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
}
