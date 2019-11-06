//
//  ViewController.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryBoarded {
    
    var coordinator: Coordinator?
    var viewModel: ViewControllerViewModel?
    var disposeBag = DisposeBag()
    
    var refreshControl: UIRefreshControl?
    
    private lazy var isRefreshing: Observable<Bool> = {
        let refreshControl = self.refreshControl
        return refreshControl?.rx.controlEvent(.valueChanged)
            .map { return refreshControl?.isRefreshing ?? false } ?? .just(false)
    }()
    
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerViewModel()
        tableView.dataSource = nil
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        self.viewModel?.loadInProgress.accept(true)
        self.refreshControl?.beginRefreshing()
        isRefreshing.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] executing in
                self?.refreshControl!.beginRefreshing()
                self?.viewModel?.loadInProgress.accept(true)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if tableView.dataSource == nil {
            viewModel?.data.do(onNext: { [weak self] source in
                    self?.refreshControl?.endRefreshing()
                    self?.viewModel?.loadInProgress.accept(false)
                })
                .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: SourceTableViewCell.self)) { _, source, cell in
                    cell.title.text = source.name
                    cell.descriptionLabel.text = source.description
                    cell.source = source
                }
                .disposed(by: disposeBag)
            
            tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.tableView.cellForRow(at: indexPath) as? SourceTableViewCell, let source = cell.source, let coordinator = self?.coordinator as? MainCoordinator {
                    coordinator.moveToArticles(with: source)
                }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                }).disposed(by: disposeBag)
        }
        
        viewModel?.data.asDriver()
            .map { "\($0.count) Sources" }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }

}

