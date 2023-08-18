//
//  HttpUtility.swift
//  JetDevsHomeWork
//

import Foundation
import UIKit

struct HttpUtility {
    
    func postApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

            if(data != nil && data?.count != 0) {
                do {

                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                } catch let decodingError {
                    
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
}
