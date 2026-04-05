//
//  Untitled.swift
//  CoreNav
//
//  Created by Yadu Madhavan on 05/04/26.
//

import Foundation

public enum AppTab: String, CaseIterable, Sendable {
    case home
    case directory
    case patients
    case settings
    
    // Display Title
    public var title: String {
        switch self {
        case .home: return "Home"
        case .directory: return "Directory"
        case .patients: return "Patients"
        case .settings: return "Settings"
        }
    }
    
    // Icon when unselected (e.g., outline versions)
    public var defaultIcon: String {
        switch self {
        case .home: return "house"
        case .directory: return "folder"
        case .patients: return "person.3"
        case .settings: return "gearshape"
        }
    }
    
    // Icon when selected (e.g., filled versions)
    public var selectedIcon: String {
        switch self {
        case .home: return "house.fill"
        case .directory: return "folder.fill"
        case .patients: return "person.3.fill"
        case .settings: return "gearshape.fill"
        }
    }
}
