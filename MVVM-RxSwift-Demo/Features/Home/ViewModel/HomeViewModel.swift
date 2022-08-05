//
//  HomeViewModel.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class HomeViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var usersModelSubject = PublishSubject<[UserData]>()
    
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
    var usersModelObservable: Observable<[UserData]> {
        return usersModelSubject.asObservable()
    }
    
    func getUsers(){
        loadingBehavior.accept(true)
        APIServices.instance.getData(url: "https://reqres.in/api/users?delay=3", method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) { [weak self] (users: Users?, userError: BaseErrorModel?, error )in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let userError = userError {
                print(userError.message ?? "")
            } else {
                guard let users = users else { return }
                if users.data?.count ?? 0 > 0 {
                    self.usersModelSubject.onNext(users.data ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
