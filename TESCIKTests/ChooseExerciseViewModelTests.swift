//
//  ChooseExerciseViewModelTests.swift
//  TESCIKTests
//
//  Created by Kuba on 27/12/2023.
//

import XCTest
@testable import TESCIK // Replace with your actual project name

class MockRealmService: RealmServiceProtocol {
    func fetchTrainingSessions(completion: @escaping (Result<[TESCIK.TrainingSession], Error>) -> Void) {
        
    }
    
    func deleteTrainingSession(_ session: TESCIK.TrainingSession, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    var saveResult: Result<Void, Error>?

    func save(_ trainingSession: TrainingSession, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = saveResult {
            completion(result)
        }
    }
}

class ChooseExerciseViewModelTests: XCTestCase {

    var viewModel: ChooseExerciseViewModel!
    var mockRealmService: MockRealmService!

    override func setUp() {
        super.setUp()
        mockRealmService = MockRealmService()
        viewModel = ChooseExerciseViewModel(realmService: mockRealmService)
    }

    override func tearDown() {
        viewModel = nil
        mockRealmService = nil
        super.tearDown()
    }

    func testSaveTrainingSuccess() {
        // Prepare mock data
        let exercise = Exercise() // Setup your Exercise instance
        let setsModel = SetsModel() // Setup your SetsModel instance
        let exerciseToSetsMap = [exercise: [setsModel]]

        // Simulate successful save
        mockRealmService.saveResult = .success(())

        let saveExpectation = expectation(description: "Save training session")
        
        viewModel.saveTraining(with: exerciseToSetsMap) { result in
            switch result {
            case .success():
                // Assert successful save
                saveExpectation.fulfill()
            case .failure(let error):
                XCTFail("Save failed with error: \(error)")
            }
        }
        wait(for: [saveExpectation], timeout: 5.0)
    }

    func testSaveTrainingFailure() {
        let exercise = Exercise() // Setup your Exercise instance
        let setsModel = SetsModel() // Setup your SetsModel instance
        let exerciseToSetsMap = [exercise: [setsModel]]

        // Simulate failure
        let error = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockRealmService.saveResult = .failure(error)

        let saveExpectation = expectation(description: "Save training session failure")
        
        viewModel.saveTraining(with: exerciseToSetsMap) { result in
            if case .failure = result {
                // Assert failure
                saveExpectation.fulfill()
            } else {
                XCTFail("Expected failure, but succeeded")
            }
        }
        wait(for: [saveExpectation], timeout: 5.0)
    }
}
