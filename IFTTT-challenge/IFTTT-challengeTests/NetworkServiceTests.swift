//
//  NetworkServiceTests.swift
//  IFTTT-challengeTests
//
//  Created by Andrew Porter on 5/12/23.
//

import XCTest
import Combine
@testable import IFTTT_challenge

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

final class NetworkServiceTests: XCTestCase {
    
    var bag: Set<AnyCancellable>!
    var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        bag = []
        sut = NetworkService()
    }
    
    override func tearDown() {
        bag = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadJsonResource() {
        let expectation = XCTestExpectation(description: "JSON is loaded and parsed")
        
        sut.fetch("JSON-mock", bundle: Bundle(for: type(of: self)))
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { (users: [User]) in
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].id, 1)
                XCTAssertEqual(users[0].name, "User One")
                XCTAssertEqual(users[0].email, "userone@test.com")
            }
            .store(in: &bag)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
