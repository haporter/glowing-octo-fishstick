//
//  AppletService.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/12/23.
//

import Foundation
import Combine

protocol JSONDecoderType {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

protocol AppletServiceType {
    func fetchApplets() -> AnyPublisher<[AppletPreview], Error>
    func fetchApplet(with id: String) -> AnyPublisher<AppletDetail?, Error>
}

struct AppletService: AppletServiceType {
    
    let network: NetworkServiceType
    let decoder: JSONDecoderType
    
    init(network: NetworkServiceType = NetworkService(), decoder: JSONDecoderType = JSONDecoder.appletDecoder) {
        self.network = network
        self.decoder = decoder
    }
    
    private var liveApplets: some Publisher<DTOApplets, Error> {
        network
            .fetch("applets",
                   decoder: decoder,
                   bundle: .main)
            .share()
    }
    
    func fetchApplets() -> AnyPublisher<[AppletPreview], Error> {
        liveApplets
            .map(\.liveApplets)
            .map({ dtoApplets in
                dtoApplets
                    .map(AppletPreview.init(dtoApplet: ))
            })
            .eraseToAnyPublisher()
    }
    
    func fetchApplet(with id: String) -> AnyPublisher<AppletDetail?, Error> {
        liveApplets
            .map(\.liveApplets)
            .map { applets in
                applets
                    .first(where: { $0.id == id })
                    .map { AppletDetail(dtoApplet: $0)}
            }
            .eraseToAnyPublisher()
    }
}

struct DTOApplets: Decodable {
    let liveApplets: [DTOApplet]
}

private extension JSONDecoder {
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

