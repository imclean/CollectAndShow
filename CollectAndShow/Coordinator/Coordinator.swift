//
//  Coordinator.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set } 
    
    func start()
}
