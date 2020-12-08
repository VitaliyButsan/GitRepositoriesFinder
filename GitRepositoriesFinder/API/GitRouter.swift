//
//  GitRouter.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import Foundation
import Moya

enum GitRouter {
    case searchRepositories(name: String, page: Int)
}

// MARK: - router target type protocol

extension GitRouter: TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
    
    var path: String {
        "/search/repositories"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var params: [String : String] {
        switch self {
        case .searchRepositories(name: let name, page: let page):
            return [
                     "q" : "\(name)",
                     "page" : "\(page)",
                     "per_page" : "15",
                   ]
        }
    }
    
    var task: Task {
        .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        ["accept" : "application/vnd.github.v3+json"]
    }
}
