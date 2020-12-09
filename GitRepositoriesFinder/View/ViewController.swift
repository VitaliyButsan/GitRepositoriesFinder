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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

