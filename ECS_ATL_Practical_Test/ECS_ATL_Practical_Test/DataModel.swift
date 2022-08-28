//
//  DataModel.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/28.
//

struct UserList: Codable {
    var users: [UserListDetails]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var tempItem: [UserListDetails] = []
        
        while !container.isAtEnd {
            let item = try container.decode(UserListDetails.self)
            tempItem.append(item)
        }
        
        users = tempItem
    }
}

struct UserListDetails: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
}
