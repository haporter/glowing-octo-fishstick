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
}
