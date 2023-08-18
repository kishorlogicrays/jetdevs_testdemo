//
//  LoginViewController.swift
//  JetDevsHomeWork
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnClose: UIButton!

    let disposeBag = DisposeBag()
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        loginViewModel.delegate = self
        setupUI()
        setupBindings()
    }

    func setupUI() {
        
        self.viewEmail.layer.cornerRadius = 4.0
        self.viewEmail.layer.borderWidth = 1.0
        self.viewEmail.layer.borderColor = UIColor.lightGray.cgColor
        
        self.viewPassword.layer.cornerRadius = 4.0
        self.viewPassword.layer.borderWidth = 1.0
        self.viewPassword.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupBindings() {
        txtEmail.rx.text.bind(to: loginViewModel.emailSubject).disposed(by: disposeBag)
        txtPassword.rx.text.bind(to: loginViewModel.passwordSubject).disposed(by: disposeBag)
        
        loginViewModel.isValidForm.bind(to: btnLogin.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValidForm.map { isvalid in
            return isvalid ? UIColor(named: "ButtonEnableColor") : UIColor(named: "ButtonDisableColor")
        }.bind(to: btnLogin.rx.backgroundColor).disposed(by: disposeBag)

    }

    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.showLoading()
        loginViewModel.didTapLogin()
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension LoginViewController: LogInDelegate {

    func didLogIn(loginResponse: LoginResponseData) {
        self.hideLoading()
        UserInfo().loggedInUser = loginResponse
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    func didFailLogIn(message: String) {
        self.hideLoading()
        self.showAlert(string: message)
    }
}
