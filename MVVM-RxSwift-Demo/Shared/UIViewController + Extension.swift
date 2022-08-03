//
//  UIViewController + Extension.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 01/08/2022.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showIndicator(withTitle title: String, and description: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    
    func showAlertWithImage(withTitle: String, andMessage message: String, andImage image: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController( title: withTitle, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
                    (completion ?? {})()
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
