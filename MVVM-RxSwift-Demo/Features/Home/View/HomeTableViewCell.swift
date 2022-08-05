//
//  UserTableViewCell.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import UIKit
import CoreMIDI

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(userData: UserData?) {
        userImageView.loadImage(userData?.avatar ?? "")
        nameLabel.text = "\( userData?.firstName ?? "") \(userData?.lastName ?? "")"
        emailLabel.text = "\( userData?.email ?? "")"
        idLabel.text = "\( userData?.id ?? 0)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
