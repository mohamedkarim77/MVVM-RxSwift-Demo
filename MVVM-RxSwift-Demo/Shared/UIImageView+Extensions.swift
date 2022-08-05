//
//  UIImageView+Extensions.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ imageURL: String) {
        let url = URL(string: imageURL)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}
