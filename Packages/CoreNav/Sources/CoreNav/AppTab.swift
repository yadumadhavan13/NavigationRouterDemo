//
//  Untitled.swift
//  CoreNav
//
//  Created by Yadu Madhavan on 05/04/26.
//

import Foundation

public enum AppTab: String, CaseIterable, Sendable {
    case recents
    case directory
    case settings
    
    // Display Title
    public var title: String {
        switch self {
        case .recents: return "Recents"
        case .directory: return "Directory"
        case .settings: return "Settings"
        }
    }
    
    // Icon when unselected (e.g., outline versions)
    public var defaultIcon: String {
        switch self {
        case .recents: return "house"
        case .directory: return "folder"
        case .settings: return "gearshape"
        }
    }
    
    // Icon when selected (e.g., filled versions)
    public var selectedIcon: String {
        switch self {
        case .recents: return "house.fill"
        case .directory: return "folder.fill"
        case .settings: return "gearshape.fill"
        }
    }
}
