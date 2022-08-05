//
//  DetailsViewController.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure(userData: UserData?) {
        userImageView.loadImage(userData?.avatar ?? "")
        nameLabel.text = "\( userData?.firstName ?? "") \(userData?.lastName ?? "")"
        emailLabel.text = "\( userData?.email ?? "")"
    }
}
