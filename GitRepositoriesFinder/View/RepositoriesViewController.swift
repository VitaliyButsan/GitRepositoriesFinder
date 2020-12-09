//
//  ViewController.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
    
    private let viewModel = RepositoriesViewModel()
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { searchController.searchBar }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = 130
        setupSearchBar()
        bindUI()
    }
    
    private func setupSearchBar() {
        navigationItem.title = "Search Repositories"
        searchBar.placeholder = "input repo name"
        tableView.tableHeaderView = searchController.searchBar
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func bindUI() {
        
        searchBar.rx
            .text
            .orEmpty
            .bind(to: viewModel.inputQuery)
            .disposed(by: disposeBag)
        
        searchBar.rx
            .cancelButtonClicked
            .subscribe { _ in
                self.viewModel.outputRepositories.accept([])
            }
            .disposed(by: disposeBag)
        
        viewModel.outputRepositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.reuseID, cellType: RepositoryCell.self)) { index, repo, cell in
                cell.configureCell(with: repo)
            }
            .disposed(by: disposeBag)
    }
}
