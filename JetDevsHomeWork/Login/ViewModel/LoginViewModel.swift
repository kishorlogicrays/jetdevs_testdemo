//
//  LoginViewModel.swift
//  JetDevsHomeWork
//

import RxCocoa
import RxSwift
import UIKit

protocol LogInDelegate: AnyObject {

    func didLogIn(loginResponse: LoginResponseData)
    func didFailLogIn(message: String)
}
class LoginViewModel {
    
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    
    let disposeBag = DisposeBag()
    let minPasswordCharacters = 6

    weak var delegate: LogInDelegate?

    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailSubject, passwordSubject) { email, password in
            guard email != nil && password != nil else {
                return false
            }
            return (email ?? "").validateEmail() && (password ?? "")!.count >= self.minPasswordCharacters
        }
    }

    func didTapLogin() {

        let url = URL(string: APIManager().LOGIN)!

        let json: [String: String?] = ["email": emailSubject.value,
                                   "password": passwordSubject.value]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        HttpUtility().postApiData(requestUrl: url, requestBody: jsonData!, resultType: LoginResponse.self) { loginResponse in

            if loginResponse.result == 1 {
                if let resposeData = loginResponse.responseData {
                    self.delegate?.didLogIn(loginResponse: resposeData)
                }
            } else {
                if let errorMessage = loginResponse.error_message {
                    self.delegate?.didFailLogIn(message: errorMessage)
                }
            }
        }
    }
}
