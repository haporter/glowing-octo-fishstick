//
//  AppletListViewModel.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/14/23.
//

import Foundation
import SwiftUI
import Combine

class AppletListViewModel: ObservableObject {
    
    @Published var appletPreview: [AppletPreview] = []
    
    private let appletService: AppletServiceType
    private var bag = Set<AnyCancellable>()
    
    init(appletService: AppletServiceType = AppletService()) {
        self.appletService = appletService
    }
    
    func fetchApplets() {
        appletService
            .fetchApplets()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error)
                case .finished:
                    break
                }
            } receiveValue: { applets in
                debugPrint(applets.map(\.status.prettyName))
                debugPrint("Applets:", applets.count)
            }
            .store(in: &bag)
    }
}
