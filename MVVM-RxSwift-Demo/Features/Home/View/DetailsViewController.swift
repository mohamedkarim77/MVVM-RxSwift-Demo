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
    
    private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        userImageView.loadImage(viewModel.imageURL)
        nameLabel.text = viewModel.formattedName
        emailLabel.text = viewModel.formattedEmail
    }
}
