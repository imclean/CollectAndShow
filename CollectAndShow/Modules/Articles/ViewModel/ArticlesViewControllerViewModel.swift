//
//  ArticlesViewControllerViewModel.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticlesViewControllerViewModel {
    
    var source:Source!
    var webService:WebService!
    fileprivate let observableArticles:Observable<[Article]>!
    
    lazy var data: Driver<[Article]> = {
        return self.observableArticles.asDriver(onErrorJustReturn: [])
    }()
    
    
    init(with source:Source, webService: WebService) {
        self.source = source
        self.webService = webService
        self.observableArticles = webService.getArticles(url: "https://newsapi.org/v2/top-headlines?sources=\(source.id)&apiKey=0cf790498275413a9247f8b94b3843fd")
    }
    
}
