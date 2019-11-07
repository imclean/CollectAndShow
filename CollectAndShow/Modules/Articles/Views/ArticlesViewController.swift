//
//  ArticlesViewController.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SafariServices

class ArticlesViewController: UIViewController, StoryBoarded {
    
    var coordinator: MainCoordinator?
    var source: Source?
    var viewModel: ArticlesViewControllerViewModel?
    var webService = WebService()
    var disposeBag = DisposeBag()
    
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        if let source = source {
            viewModel = ArticlesViewControllerViewModel(with: source, webService: webService)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if tableView.dataSource == nil {
            if let viewModel = viewModel {
                viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell", cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.article = article
                    cell.titleLabel.text = article.title
                    cell.descriptionLabel.text = article.description
                }.disposed(by: disposeBag)
                
                viewModel.data.asDriver()
                    .map { "\($0.count) Articles"}
                    .drive(navigationItem.rx.title)
                    .disposed(by: disposeBag)
            }
            
            tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.tableView.cellForRow(at: indexPath) as? ArticleTableViewCell, let article = cell.article {
                    if let url = URL(string: article.url) {
                        let config = SFSafariViewController.Configuration()
                        let safari = SFSafariViewController(url: url, configuration: config)
                        safari.modalPresentationStyle = .overFullScreen
                        self?.present(safari, animated: true)
                    }
                }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                }).disposed(by: disposeBag)
        }
        
    }
    
}
