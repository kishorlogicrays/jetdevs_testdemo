//
//  UIViewControllerExtesion.swift
//  JetDevsHomeWork
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {

    func showAlert(string: String) -> Void {

        let alert : UIAlertController = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: "OK", style: .default) { (alert) in

        }
        alert.addAction(alertCancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showLoading() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.show(animated: true)
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension Date {
    func timeAgoSinceDate() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)

        if let year = components.year, year > 0 {
            return "\(year) year" + (year > 1 ? "s" : "") + " ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month" + (month > 1 ? "s" : "") + " ago"
        } else if let week = components.weekOfYear, week > 0 {
            return "\(week) week" + (week > 1 ? "s" : "") + " ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day" + (day > 1 ? "s" : "") + " ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour" + (hour > 1 ? "s" : "") + " ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute" + (minute > 1 ? "s" : "") + " ago"
        } else if let second = components.second, second > 0 {
            return "\(second) second" + (second > 1 ? "s" : "") + " ago"
        } else {
            return "Just now"
        }
    }
}
