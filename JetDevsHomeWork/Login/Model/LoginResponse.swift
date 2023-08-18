//
//  LoginResponse.swift
//  JetDevsHomeWork
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct LoginResponse: Codable {
    
    let result: Int?
    let error_message: String?
    let responseData: LoginResponseData?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case error_message = "error_message"
        case responseData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Int.self, forKey: .result)
        error_message = try values.decodeIfPresent(String.self, forKey: .error_message)
        responseData = try values.decodeIfPresent(LoginResponseData.self, forKey: .responseData)
    }

}
