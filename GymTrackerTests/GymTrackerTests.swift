//
//  TESCIKTests.swift
//  TESCIKTests
//
//  Created by Kuba on 27/12/2023.
//

import XCTest
@testable import TESCIK

final class TESCIKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSaveTrainingSession() {
        let realmService = RealmService()
        let trainingSession = TrainingSession() // Create a mock TrainingSession

        let saveExpectation = expectation(description: "Save training session")

        realmService.save(trainingSession) { result in
            switch result {
            case .success():
                // Verify that the session was saved successfully
                // ...
                saveExpectation.fulfill()

            case .failure(let error):
                XCTFail("Save failed with error: \(error)")
            }
        }

        wait(for: [saveExpectation], timeout: 5.0)
    }

    func testFetchTrainingSessions() {
        let realmService = RealmService()

        let fetchExpectation = expectation(description: "Fetch training sessions")

        realmService.fetchTrainingSessions { result in
            switch result {
            case .success(_):
                fetchExpectation.fulfill()

            case .failure(let error):
                XCTFail("Fetch failed with error: \(error)")
            }
        }

        wait(for: [fetchExpectation], timeout: 5.0)
    }

    func testDeleteTrainingSession() {
        let realmService = RealmService()
        let trainingSession = TrainingSession() // Create a mock TrainingSession
        
        let saveExpectation = expectation(description: "Save training session")
            realmService.save(trainingSession) { result in
                switch result {
                case .success():
                    saveExpectation.fulfill()
                case .failure(let error):
                    XCTFail("Save failed with error: \(error)")
                }
            }
            wait(for: [saveExpectation], timeout: 5.0)

        let deleteExpectation = expectation(description: "Delete training session")

        realmService.deleteTrainingSession(trainingSession) { result in
            switch result {
            case .success():
                deleteExpectation.fulfill()

            case .failure(let error):
                XCTFail("Delete failed with error: \(error)")
            }
        }

        wait(for: [deleteExpectation], timeout: 10.0)
    }

    
    

}
