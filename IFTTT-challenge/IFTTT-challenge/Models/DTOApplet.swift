//
//  DTOApplet.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/12/23.
//

import Foundation

struct DTOApplet: Decodable {
    let createdAt: Date
    let id: String
    let serviceSlug: String
    let byServiceOwner: Bool
    let name: String
    let description: String
    let brandColor: String
    let status: AppletStatus
    let author: String
    let installsCount: Int
    let appletFeedbackByUser: Bool?
    let backgroundImages: BackgroundImages
    let valuePropositions: [String]?
    let channels: [Channel]
}
