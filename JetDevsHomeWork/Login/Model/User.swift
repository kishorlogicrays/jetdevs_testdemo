//
//  User.swift
//  JetDevsHomeWork
//

import UIKit
import RxCocoa
import RxSwift

struct User: Codable {
    
    let userId: Int?
    let userName: String?
    let userProfileUrl: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {

        case userId = "user_id"
        case userName = "user_name"
        case userProfileUrl = "user_profile_url"
        case createdAt = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        userProfileUrl = try values.decodeIfPresent(String.self, forKey: .userProfileUrl)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }

}
