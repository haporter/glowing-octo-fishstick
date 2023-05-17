//
//  AppletDetail.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/15/23.
//

import Foundation

struct AppletDetail: Decodable {
    let name: String
    let id: String
    let author: String
    let description: String
    let channels: [Channel]
    let status: AppletStatus
    
    init(dtoApplet: DTOApplet) {
        self.name = dtoApplet.name
        self.id = dtoApplet.id
        self.author = dtoApplet.author
        self.description = dtoApplet.description
        self.channels = dtoApplet.channels
        self.status = dtoApplet.status
    }
}
