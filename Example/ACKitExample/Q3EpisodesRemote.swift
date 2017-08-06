//
//  Q3EpisodesRemote.swift
//  <?>App
//
//  Created by Austin Chen on 2017-08-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation
import ACKit
import Alamofire

protocol Q3EpisodesRemoteType {
    func fetchEpisodes(_ completion: @escaping (_ result: ACRemoteResult<[Q3JsonEpisode]>) -> ())
}

class Q3EpisodesRemote: ACRemote, Q3EpisodesRemoteType {
    
    func fetchEpisodes(_ completion: @escaping (_ result: ACRemoteResult<[Q3JsonEpisode]>) -> ()) {
        
        let request = self.alamoFireManager.request(self.baseUrl + "/q3new/_design/episodes/_list/aus/latest", headers: self.remoteSession?.postAuthenticationHttpHeaders)
        
        request.responseArray(queue: ACRemoteSettings.concurrentQueue, keyPath: nil, context: nil) { (response: DataResponse<[Q3JsonEpisode]>) in
            if response.isValid,
                let v = response.result.value {
                completion(ACRemoteResult.success(v))
            } else {
                completion(ACRemoteResult.failure(response.error))
            }
        }
    }
}

