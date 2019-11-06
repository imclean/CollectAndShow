//
//  WebService.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias completion = () -> ([Source])

class WebService {
    
    func getSources(url: String, callback: @escaping ([Source]) -> Void) -> URLSessionTask? {
        guard let url = URL(string: url) else {
            callback([])
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let allScources = try! JSONDecoder().decode(Sources.self, from: data)
                callback(allScources.sources)
            }
        }
        task.resume()
        return task
    }
    
    func getArticles(url: String) -> Observable<[Article]> {
        guard let url = URL(string: url) else {
            return Observable.just([])
        }
        let urlrequest = URLRequest(url: url)
        
        return URLSession.shared.rx.data(request: urlrequest)
            .map {
                let articles = try! JSONDecoder().decode(Articles.self, from: $0)
                return articles.articles
            }
    }
}

extension WebService: ReactiveCompatible {}
extension Reactive where Base: WebService {
    
    func getSources(url: String) -> Observable<[Source]> {
        return Observable.create { observer in
            let request = self.base.getSources(url: url, callback: { sources in
                observer.onNext(sources)
            })
            return Disposables.create {
                if let request = request {
                    request.cancel()
                }
            }
        }.observeOn(MainScheduler.instance)
    }
}
