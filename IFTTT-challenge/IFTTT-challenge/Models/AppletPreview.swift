//
//  AppletPreview.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/15/23.
//

import Foundation

struct AppletPreview: Decodable, Identifiable {
    let id: String
    let name: String
    let author: String
    let brandColor: String
    let status: AppletStatus
    let channels: [Channel]
    
    init(dtoApplet: DTOApplet) {
        self.id = dtoApplet.id
        self.name = dtoApplet.name
        self.author = dtoApplet.author
        self.brandColor = dtoApplet.brandColor
        self.status = dtoApplet.status
        self.channels = dtoApplet.channels
    }
}
