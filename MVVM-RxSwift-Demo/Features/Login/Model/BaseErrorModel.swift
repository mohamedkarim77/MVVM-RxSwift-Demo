//
//  BaseErrorModel.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 01/08/2022.
//

import Foundation

struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
