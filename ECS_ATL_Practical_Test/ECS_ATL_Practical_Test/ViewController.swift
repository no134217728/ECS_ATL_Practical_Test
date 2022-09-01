//
//  ViewController.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/25.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var userListTableView: UITableView!
        
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.delegate = self
        
        if viewModel.useMock {
            viewModel.fetchUserListAll()
                .bind(to: userListTableView.rx.items(cellIdentifier: "userListCell", cellType: UserTableViewCell.self)) { (row, element, cell) in
                    cell.configTheCell(details: element)
                }
                .disposed(by: disposeBag)
        } else {
            viewModel.userList.bind(to: userListTableView.rx.items(cellIdentifier: "userListCell", cellType: UserTableViewCell.self)) { (row, element, cell) in
                cell.configTheCell(details: element)
            }
            .disposed(by: disposeBag)
            
            userListTableView.rx.didEndDragging.subscribe { [weak self] _ in
                guard let self = self else { return }
                let offSetY = self.userListTableView.contentOffset.y
                let contentHeight = self.userListTableView.contentSize.height
                
                if offSetY > (contentHeight - self.userListTableView.frame.size.height - 50) {
                    self.viewModel.fetchPaging.onNext(())
                }
            }.disposed(by: disposeBag)
            
            viewModel.fetchPaging.onNext(())
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
