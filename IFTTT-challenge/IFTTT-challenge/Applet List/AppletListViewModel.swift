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
        
        subscribe()
    }
    
    private func subscribe() {
        fetchApplets()
            .assign(to: &$appletPreview)
    }
    
    private func fetchApplets() -> some Publisher<[AppletPreview], Never> {
        appletService
            .fetchApplets()
            .catch({ _ in
                // TODO: handle error
                Empty(outputType: [AppletPreview].self, failureType: Never.self)
            })
            .receive(on: RunLoop.main)
            
    }
    
    func channelIcons(for applet: AppletPreview) -> [URL] {
        applet.channels.map(\.monochromeImageUrl)
    }
}
