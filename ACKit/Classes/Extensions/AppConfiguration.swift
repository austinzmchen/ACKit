//
//  AppConfigurator.swift
//  PostSurgicalMonitoring
//
//  Created by Austin Chen on 2016-06-01.
//  Copyright © 2016 Hubub Health. All rights reserved.
//

import Foundation

protocol AppConfiguratorType {
    var remoteSession: ACRemoteSession? {get set}
    var syncCoordinator: ACSyncCoordinator? {get set}
    func configure() -> AppConfiguration?
}

struct AppConfigurator: AppConfiguratorType {
    // builder properties
    var remoteSession: ACRemoteSession?
    var syncCoordinator: ACSyncCoordinator?
    
    public func configure() -> AppConfiguration? {
        guard let rs = self.remoteSession else {
            fatalError("AppConfigurator - configure error")
        }
        let configuration = AppConfiguration()
        
        // set up configration here
        
        return configuration
    }
}


let kAppConfigurationRemoteSession = "remoteSession"
let kAppConfigurationSyncCoordinator = "syncCoordinator"

typealias AppConfiguration = NSMutableDictionary // subclass dictionary would require override methods

extension AppConfiguration {
    
    var isValid: Bool {
        get {
            if let _ = self[kAppConfigurationRemoteSession] as? ACRemoteSession,
                let _ = self[kAppConfigurationSyncCoordinator] as? ACSyncCoordinator
            {
                return true
            } else {
                return false
            }
        }
    }
    
    static func appVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static func appBuild() -> String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    static func versionWithBuild() -> String {
        return String(format: "%@ (%@)", self.appVersion(), self.appBuild())
    }
}

