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
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
