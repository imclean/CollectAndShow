//
//  ArticleModelTests.swift
//  CollectAndShowTests
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import XCTest
@testable import CollectAndShow

class ArticleModelTests: XCTestCase {

    private let mockGoodSourceJson = Data("""
    {
      "title" : "123",
      "url" : "Test",
      "description" : "Test",
    }
    """.utf8)
    
    private let mockBadSourceJson = Data("""
    {
      "test" : "123",
      "data" : "Test",
    }
    """.utf8)
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testSourceIsCodeable() {
        // Given
        
        // When
        let source = try! JSONDecoder().decode(Article.self, from: mockGoodSourceJson)
        // Then
        XCTAssertNotNil(source, "Source Should Not Be Nil")
    }
    
    func testBadSourceThrows() {
        // Given
        // Bad Json
        // When
        // Trying to Decode it
        // Then
        // Throws Error
        XCTAssertThrowsError(try JSONDecoder().decode(Article.self, from: mockBadSourceJson))
    }
    
    

}
