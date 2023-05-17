//
//  AppletDetailViewModel.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/16/23.
//

import Foundation
import SwiftUI
import Combine

class AppletDetailViewModel: ObservableObject {
    
    @Published var applet: AppletDetail?
    
    private let id: String
    private let appletService: AppletServiceType
    private var bag = Set<AnyCancellable>()
    
    init(id: String, service: AppletServiceType = AppletService()) {
        self.id = id
        self.appletService = service
        
        subscribe()
    }
    
    func subscribe() {
        $applet
            .sink { value in
                debugPrint(value)
            }
            .store(in: &bag)
    }
    
    func fetchAppletDetail() /*-> some Publisher<AppletDetail?, Never>*/ {
        appletService
            .fetchApplet(with: id)
            .catch { _ in
                // TODO: handle error
                Empty(outputType: AppletDetail?.self, failureType: Never.self)
            }
            .receive(on: RunLoop.main)
            .assign(to: &$applet)
    }
    
    func channelIcons() -> [URL] {
        applet?.channels.map(\.lrgImageUrl) ?? []
    }
}
