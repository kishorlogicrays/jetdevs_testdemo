//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher
import RxSwift

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let loginData = UserInfo().loggedInUser {

            loginView.isHidden = false
            nonLoginView.isHidden = true

            nameLabel.text = loginData.user?.userName
            let daysAgo = convertToDaysAgo(dateString: (loginData.user?.createdAt) ?? "")
            daysLabel.text = "Created \(daysAgo ?? "")"
            KF.url(URL(string: (loginData.user?.userProfileUrl ?? ""))!).set(to: headImageView)
        } else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
        }
    }

    func convertToDaysAgo(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let pastDate = dateFormatter.date(from: dateString) {
            return pastDate.timeAgoSinceDate()
        } else {
            return "Invalid date format"
        }
    }

	@IBAction func loginButtonTap(_ sender: UIButton) {

        let loginVc = LoginViewController()
        loginVc.modalPresentationStyle = .fullScreen
        self.present(loginVc, animated: true)
	}
}
