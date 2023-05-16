//
//  AppletStatus.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/15/23.
//

import Foundation
import SwiftUI

enum AppletStatus: String, Decodable {
    case enabled = "enabled_for_user"
    case disabled = "disabled_for_user"
    case neverEnabled = "never_enabled_for_user"
    
    var prettyName: String {
        switch self {
        case .enabled:
            return "On"
        case .disabled:
            return "Off"
        case .neverEnabled:
            return "Disconnected"
        }
    }
    
    var color: Color {
        switch self {
        case .enabled:
            return .mint
        case .disabled:
            return .gray
        case .neverEnabled:
            return .black
        }
    }
}
