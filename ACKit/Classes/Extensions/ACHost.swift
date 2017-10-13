//
//  ACHost.swift
//  <?>App
//
//  Created by Austin Chen on 2017-01-26.
//  Copyright © 2017 10.1. All rights reserved.
//

import Foundation

struct ACHost {
    let name: String
    let domain: String
}

extension ACHost {
    static let hosts: [ACHost] = [ACHost(name: "Prod", domain: "prod.com"),
                                  ACHost(name: "Staging", domain: "staging.com")]
    
    var prefixUrl: String {
        return "http://" + domain + "/suffix/"
    }
}
