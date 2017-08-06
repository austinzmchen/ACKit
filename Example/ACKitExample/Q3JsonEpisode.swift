//
//  Q3JsonEpisode.swift
//  <?>App
//
//  Created by Austin Chen on 2017-04-25.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation
import ACKit
import ObjectMapper

class Q3JsonEpisode: ACSyncableJsonRecord {
    var title: String?
    var people: String?
    var duration: Float?
    var audioStreamUrlStr: String?
    var videoStreamUrlStr: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title <- map["title"]
        people <- map["people"]
        duration <- map["duration"]
        audioStreamUrlStr <- map["streamUrlAudio"]
        videoStreamUrlStr <- map["streamUrlVideo"]
    }
}

