//
//  Article.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation

class Articles: Decodable {
    
    var articles: [Article]
    
    required init(from decoder:Decoder) throws {
        do {
            let map = try decoder.container(keyedBy: CodingKeys.self)
            self.articles = try map.decode([Article].self, forKey: .articles)
        } catch let error {
            throw error
        }
    }
    
    public enum CodingKeys: CodingKey {
        case articles
    }
}

class Article: Decodable {
    var title: String
    var description: String?
    var url: String
    
    required init(from decoder: Decoder) throws {
        do {
            let map = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try map.decode(String.self, forKey: .title)
            self.description = try map.decode(String?.self, forKey: .description)
            self.url = try map.decode(String.self, forKey: .url)
        } catch let error {
            throw error
        }
    }
    
    private enum CodingKeys: CodingKey {
        case title
        case description
        case url
    }
}
