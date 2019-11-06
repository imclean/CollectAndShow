//
//  Source.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation

class Sources: Decodable {
    
    var sources:[Source]
    
    required init(from decoder: Decoder) throws {
        do {
            let map = try decoder.container(keyedBy: CodingKeys.self)
            self.sources = try map.decode([Source].self, forKey: .sources)
        } catch let error {
            throw error
        }
    }
    
    private enum CodingKeys: CodingKey {
        case sources
    }
}

class Source: Decodable {
    var id: String
    var name: String
    var description: String
    
    required init(from decoder: Decoder) throws {
        do {
            let map = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try map.decode(String.self, forKey: .id)
            self.name = try map.decode(String.self, forKey: .name)
            self.description = try map.decode(String.self, forKey: .description)
        } catch let error {
            throw error
        }
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case name
        case description
    }
}
