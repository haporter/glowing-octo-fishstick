//
//  Channel.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/12/23.
//

import Foundation
import CoreLocation

struct Channel: Decodable {
    let moduleName: String
    let name: String
    let shortName: String
    let descriptionHTML: String?
    let brandColor: String
    let monochromeImageUrl: URL
    let lrgMonochromeImageUrl: URL
    let imageUrl: URL
    let lrgImageUrl: URL
    let isHidden: Bool?
    let connected: Bool
    let requiresUserAuthentication: Bool
    let fenceArea: FenceArea?
}
