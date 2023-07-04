//
//  QuantiTests.swift
//  QuantiTests
//
//  Created by Venda Pernička on 28.06.2023.
//

import XCTest
@testable import Quanti_test
import Combine

final class SpaceXAPITests: XCTestCase {

  var cancellables = Set<AnyCancellable>()
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
      
      
      let api = SpaceXAPI()
      let expectation = self.expectation(description: "Result")
      let expectationFinished = self.expectation(description: "Finished")
      api.getAllRockets().sink { completed in
        switch completed {
          case .failure(let error):
            XCTFail("api error: \(error)")
        case .finished:
          expectationFinished.fulfill()
        }
      } receiveValue: { rockets in
        print(rockets)
        XCTAssert(rockets.count > 2)
        expectation.fulfill()
      }
      .store(in: &cancellables)

      await waitForExpectations(timeout: 5, handler: nil)

    }

    func testPerformanceExample() throws {
      
    }

}


