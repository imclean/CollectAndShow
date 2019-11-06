//
//  WebServiceTests.swift
//  CollectAndShowTests
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import XCTest
@testable import CollectAndShow

class WebServiceTests: XCTestCase {
    
    var urlStringSources = "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd"
    var urlStringArticles = "https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=0cf790498275413a9247f8b94b3843fd"
    
    override func setUp() {
        
    }

    override func tearDown() {
       
    }

    func testWebServiceSourcesReturnsAValue() {
        // Given
        
        // When
        let obs = WebService().rx.getSources(url: urlStringSources)
        // Then
        XCTAssertNotNil(obs, "Sources Response should always be a value")
    }
    
    func testWebServiceArticlesReturnsAValue() {
        // Given
        
        // When
        let obs = WebService().rx.getSources(url: urlStringArticles)
        // Then
        XCTAssertNotNil(obs, "Articles Response should always be a value")
    }

}
