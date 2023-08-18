//
//  Data.swift
//  JetDevsHomeWork
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct LoginResponseData: Codable {
    
    let user: User?

    enum CodingKeys: String, CodingKey {

        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}
