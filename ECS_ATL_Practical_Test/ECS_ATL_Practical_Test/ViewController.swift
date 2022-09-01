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
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
