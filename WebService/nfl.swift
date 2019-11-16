//
//  nfl.swift
//  WebService
//
//  Created by Dayton Steffeny on 11/15/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import Foundation

struct standing {
    var name: String
    var spot: String
    var artworkURL: String
    var genres = [String]()
    
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.spot = dictionary["spot"] as? String ?? ""
        self.artworkURL = dictionary["artworkUrl"] as? String ?? ""
        
        if let genres = dictionary["genres"] as? [Dictionary<String, Any>] {
            for item in genres {
                self.genres.append(item["name"] as? String ?? "")
            }
        }
    }
}
