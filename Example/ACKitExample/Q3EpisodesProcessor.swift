//
//  Q3EpisodesProcessorType.swift
//  <?>App
//
//  Created by Austin Chen on 2017-08-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation
import ACKit

protocol Q3EpisodesProcessorType: ACSyncableProcessorType {
}

@objc class Q3EpisodesProcessor: NSObject, Q3EpisodesProcessorType {
    
    let syncContext: ACSyncContext
    
    required init (context: ACSyncContext) {
        self.syncContext = context
    }
    
    lazy var episodeRemote: Q3EpisodesRemote = {
        return Q3EpisodesRemote(remoteSession: self.syncContext.remoteSession)
    }()
    
    func sync(_ completion: @escaping (_ success: Bool, _ syncedObjects: [AnyObject]?, _ error: Error?) -> ()) {
        self.episodeRemote.fetchEpisodes { (remoteResult) in
            switch remoteResult {
            case .success(let episodes):
                _ = self.store(episodes, toManagedObjectType: Q3Episode.self)
                DispatchQueue.main.async(execute: {
                    completion(true, episodes, nil)
                })
                break
            case .failure(let error):
                DispatchQueue.main.async(execute: {
                    completion(false, nil, error)
                })
                break
            }
        }
    }
}


fileprivate let kRemoteFetchSizeDefault: Int = 16

