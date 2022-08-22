//
//  LoginViewModel.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 01/08/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    var phoneBehavior = BehaviorRelay<String>(value: "")
    var codeBehavior = BehaviorRelay<String>(value: "")
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    var loginModelSubject = PublishSubject<LoginSuccessModel>()
    var loginModelObservable: Observable<LoginSuccessModel> {
        return loginModelSubject
    }
    
    var isPhoneValid: Observable<Bool> {
        return phoneBehavior.asObservable().map { phone -> Bool in
            let isPhoneEmpty = phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isPhoneEmpty
        }
    }
    
    var isCodeValid: Observable<Bool> {
        return codeBehavior.asObservable().map { code -> Bool in
            let isCodeEmpty = code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isCodeEmpty
        }
    }
    
    var isLoginEnabled: Observable<Bool> {
        return Observable.combineLatest(isPhoneValid, isCodeValid ) { (isCodeEmpty, isPhoneEmpty) in
            let loginValid = !isPhoneEmpty && !isCodeEmpty
            return loginValid
        }
    }
    
    func getData() {
        loadingBehavior.accept(true)
        let params = [
            "email": phoneBehavior.value,
            "password": codeBehavior.value,
        ]
       // let headers: HTTPHeaders? = ["Content-Type": "application/json", "X-FakeAPI-Action": "register"]
        
        APIServices.instance.getData(url: "https://reqres.in/api/register", method: .post, params: params, encoding: JSONEncoding.default, headers: nil) { [weak self] (loginSuccessModel: LoginSuccessModel?, baseErrorModel: BaseErrorModel?, error) in
            guard let self = self else{return}
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let baseErrorModel = baseErrorModel {
                print(baseErrorModel.message ?? "")
            } else {
                guard let loginSuccessModel = loginSuccessModel else { return }
                self.loginModelSubject.onNext(loginSuccessModel)
                UserDefaults.standard.setValue(loginSuccessModel.token, forKey: "TOKEN")
            }
        }
    }
}
