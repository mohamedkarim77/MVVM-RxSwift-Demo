//
//  LoginViewController.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 01/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
        subscribeLoginEnabled()
    }
    
    func bindTextFieldsToViewModel() {
        phoneTextField.rx.text.orEmpty
            .bind(to: loginViewModel.phoneBehavior)
            .disposed(by: disposeBag)
        codeTextField.rx.text.orEmpty
            .bind(to: loginViewModel.codeBehavior)
            .disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        loginViewModel.loadingBehavior
            .subscribe(onNext: { loading in
            if loading {
                self.showIndicator(withTitle: "", and: "")
            }else {
                self.hideIndicator()
            }
        }
        ).disposed(by: disposeBag)
    }
    
    func subscribeToResponse() {
        loginViewModel.loginModelObservable
            .subscribe(onNext: { loginSuccessModel in
            if loginSuccessModel.token != nil {
                let vc = HomeViewController()
                let homeNavigation = UINavigationController(rootViewController: vc)
                homeNavigation.modalPresentationStyle = .fullScreen
                self.present(homeNavigation, animated: true)
            }
        })
            .disposed(by: disposeBag)
    }
    
    func subscribeToLoginButton() {
        loginButton
            .rx
            .tap
            .throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] _ in
                guard let self = self else { return }
                self.loginViewModel.getData()
            }
            ).disposed(by: disposeBag)
    }
    
    func subscribeLoginEnabled() {
        loginViewModel.isLoginEnabled
            .bind(to: loginButton.rx.isEnabled
            ).disposed(by: disposeBag)
    }
    
}
