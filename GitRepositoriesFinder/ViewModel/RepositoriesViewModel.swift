//
//  RepositoriesViewModel.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import Foundation
import RxSwift
import RxCocoa

class RepositoriesViewModel {
    
    private let disposeBag = DisposeBag()
    private let gitService = GitService()
    private var localRepositories = [Repository]()
    let inputQuery = BehaviorRelay<String>(value: "")
    var outputRepositories = BehaviorRelay<[Repository]>(value: [])
    
    init() {
        subscribeObservables()
    }
    
    private func subscribeObservables() {
        inputQuery
            .throttle(.milliseconds(400), latest: true, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                if query.count > 3 {
                    self.searchRepositories(name: query)
                } else {
                    self.outputRepositories.accept([])
                }
            })
            .disposed(by: disposeBag)
        
        gitService.response
            .subscribe(onNext: { [weak self] responseOrNil in
                guard let self = self else {
                    return
                }
                guard let response = responseOrNil else {
                    print("Error response!")
                    return
                }
                guard let result: RepositoriesDataWrapper = self.decode(data: response.data) else {
                    print("Error decoding!")
                    return
                }
                self.localRepositories += result.items
            })
            .disposed(by: disposeBag)
        
        gitService.isCompleted
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.localRepositories.sort { $0.stars > $1.stars }
                self.outputRepositories.accept(self.localRepositories)
            })
            .disposed(by: disposeBag)
    }
    
    private func searchRepositories(name: String, pages: UInt = 2) {
        gitService.searchRepositories(name: name, pages: pages)
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
