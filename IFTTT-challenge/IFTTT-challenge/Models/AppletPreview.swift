//
//  AppletPreview.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/15/23.
//

import Foundation

struct AppletPreview: Decodable {
    let name: String
    let author: String
    let status: AppletStatus
    let channels: [Channel]
}
