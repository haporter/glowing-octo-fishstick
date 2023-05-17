//
//  AppletServiceTests.swift
//  IFTTT-challengeTests
//
//  Created by Andrew Porter on 5/13/23.
//

import Foundation
import XCTest
import Combine
@testable import IFTTT_challenge

final class AppletServiceTests: XCTestCase {
    
    private var sut: AppletService!
    private var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = AppletService(network: MockNetwork())
    }
    
    override func tearDown() {
        sut = nil
        bag = []
        
        super.tearDown()
    }
    
    func testSomething() {
        
    }
}

struct MockNetwork: NetworkServiceType {
    var appletPublisher = Just(DTOApplets(liveApplets: [])).setFailureType(to: Error.self).eraseToAnyPublisher()
    
    func fetch<T>(_ resource: String, decoder: IFTTT_challenge.JSONDecoderType, bundle: Bundle) -> AnyPublisher<T, Error> where T : Decodable {
        appletPublisher
            .map { $0 as! T }
            .eraseToAnyPublisher()
    }
}

extension JSONDecoder {
    static var appletDecoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
}
