//
//  HomeViewController.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 02/08/2022.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var usersContainerView: UIView!
    @IBOutlet weak var usersTableView: UITableView!{
        didSet{
            registerCell(cellID)
        }
    }
    let cellID = "HomeTableViewCell"
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        getUsers()
        subscribeToLoadingBehavior()
        bindToTableHidden()
        bindToResponse()
       // bindToBranchSelection()
    }
    
    func registerCell(_ id: String) {
        usersTableView.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
    
    func getUsers() {
        homeViewModel.getUsers()
    }
    
    func subscribeToLoadingBehavior() {
        homeViewModel.loadingBehavior.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            }else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    func bindToTableHidden() {
        homeViewModel.isTableHiddenObservable.bind(to: usersTableView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func bindToResponse() {
        homeViewModel.usersModelObservable.bind(to: usersTableView.rx.items(cellIdentifier: cellID, cellType: HomeTableViewCell.self)) { row, user, cell in
            cell.configureCell(userData: user)
        }.disposed(by: disposeBag)
    }
    
//    func bindToBranchSelection() {
//        Observable
//            .zip(usersTableView.rx.itemSelected, usersTableView.rx.modelSelected(UserData.self))
//            .bind { [weak self] selectedIndex, user in
//                guard let self = self else { return }
//                print(selectedIndex, user.email ?? "")
//                let vc = DetailsViewController()
//                vc.configure(userData: user)
//                self.navigationController?.pushViewController(vc, animated: true)
//            }.disposed(by: disposeBag)
//    }
}
