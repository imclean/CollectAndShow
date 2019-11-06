//
//  ViewControllerViewModel.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewControllerViewModel {
    
    let loadInProgress = BehaviorRelay(value: false)
    private var onShowLoading: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    lazy var data: Driver<[Source]> = {
        return self.onShowLoading.asObservable()
            .filter { $0 == true }
            .flatMapLatest{_ in
                ViewControllerViewModel.fetchData()
            }
        .asDriver(onErrorJustReturn: [])
    }()
    
    static func fetchData() -> Observable<[Source]> {
        return WebService().rx.getSources(url: "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd")
    }
    
}
