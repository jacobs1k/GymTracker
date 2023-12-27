//
//  HistoryViewModel.swift
//  TESCIK
//
//  Created by Kuba on 22/12/2023.
//

import Foundation
import RealmSwift


class HistoryViewModel: ObservableObject {
    @Published var trainingSessions: [TrainingSession] = []
    private let realmService: RealmServiceProtocol

        init(realmService: RealmServiceProtocol = RealmService()) {
            self.realmService = realmService
            fetchTrainingSessions()
        }

        func fetchTrainingSessions() {
            realmService.fetchTrainingSessions { [weak self] result in
                switch result {
                case .success(let sessions):
                    self?.trainingSessions = sessions
                case .failure(let error):
                    print("Error fetching training sessions: \(error)")
                }
            }
        }
    
    func deleteTrainingSession(at offsets: IndexSet) {
            for index in offsets {
                let session = trainingSessions[index]
                realmService.deleteTrainingSession(session) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success():
                            self?.trainingSessions.remove(at: index)
                            self?.fetchTrainingSessions()

                        case .failure(let error):
                            print("Error deleting training session: \(error)")
                        }
                    }
                }
            }
        }
}

