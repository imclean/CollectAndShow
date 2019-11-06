//
//  StoryBoarded.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit

public enum StoryBoardName: String {
    case main = "Main"
}

protocol StoryBoarded {
    static func instantiate(with storyBoardName: StoryBoardName) -> Self
}

extension StoryBoarded {
    
    static func instantiate(with storyBoardName: StoryBoardName) -> Self {
        let id = String(describing: self)
        let storyBoard = UIStoryboard(name: storyBoardName.rawValue, bundle: Bundle.main)
        return storyBoard.instantiateViewController(identifier: id) as! Self
    }
}
