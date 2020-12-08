//
//  GitService.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class GitService {
    
    private let provider = MoyaProvider<GitRouter>()
    var response = PublishSubject<Response?>()
    var isCompleted = BehaviorRelay<Bool>(value: false)
    
    func searchRepositories(name: String, pages: UInt) {
        let group = DispatchGroup()
        
        for page in 1...pages {
            group.enter()
            provider.request(.searchRepositories(name: name, page: page)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    group.leave()
                    self.response.onNext(response)
                case .failure(let error):
                    print(error)
                    self.response.onNext(nil)
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isCompleted.accept(true)
        }
    }
}
