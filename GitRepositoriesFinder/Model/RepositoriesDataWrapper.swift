//
//  RepositoriesDataWrapper.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import Foundation

struct RepositoriesDataWrapper: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let name: String?
    let stars: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case stars = "stargazers_count"
    }
}

struct Owner: Decodable {
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
