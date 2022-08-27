//
//  NetworkService.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/26.
//

import UIKit
import Moya

enum GithubServices {
    case GetUserListDefault
    case GetUserListPage(since: Int, perPage: Int = 20)
}

extension GithubServices: TargetType {
    var baseURL: URL {
        let urlStr = "https://api.github.com"
        return URL(string: urlStr)!
    }
    
    var path: String {
        switch self {
        case .GetUserListDefault, .GetUserListPage:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            guard let url = Bundle.main.url(forResource: "MockData200", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case let .GetUserListPage(since, perPage):
            return .requestParameters(parameters: ["since": since,
                                                   "per_page": perPage], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
