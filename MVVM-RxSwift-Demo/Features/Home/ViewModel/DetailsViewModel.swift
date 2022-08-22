//
//  DetailsViewModel.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import Foundation

class DetailsViewModel {
    
    private var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    var formattedName: String {
        "\( userData.firstName ?? "") \(userData.lastName ?? "")"
    }
    
    var formattedEmail: String {
        "\( userData.email ?? "")"
    }
    
    var imageURL: String {
        userData.avatar ?? ""
    }
    
}
