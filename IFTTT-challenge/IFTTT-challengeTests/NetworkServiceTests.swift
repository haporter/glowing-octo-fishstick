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
    var decoder: JSONDecoderType!
    var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        bag = []
        decoder = JSONDecoder()
        sut = NetworkService()
    }
    
    override func tearDown() {
        bag = nil
        decoder = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadJsonResourceSuccess() {
        let expectation = XCTestExpectation(description: "JSON is loaded and parsed")
        
        sut.fetch("JSON-mock", decoder: decoder, bundle: Bundle(for: type(of: self)))
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

    func testLoadJsonResourceFailure() {
        let expectation = XCTestExpectation(description: "JSON load fails")
        
        sut.fetch("nothingFile", decoder: decoder, bundle: Bundle(for: type(of: self)))
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error as! NetworkError, .invalidResourcePath)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Test should not receive value")
                }
            } receiveValue: { (users: [User]) in
                XCTFail("Test should not receive value")
            }
            .store(in: &bag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
