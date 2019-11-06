//
//  MainCoordinator.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(with nav: UINavigationController) {
        navigationController = nav
    }
    
    func start() {
        let vc = ViewController.instantiate(with: .main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func moveToArticles(with source:Source) {
        let vc = ArticlesViewController.instantiate(with: .main)
        vc.coordinator = self
        vc.source = source
        navigationController.pushViewController(vc, animated: true)
    }
    
}
