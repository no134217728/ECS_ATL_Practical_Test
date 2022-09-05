//
//  DetailsViewController.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/9/1.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var isStaff: UIButton!
    
    let disposeBag = DisposeBag()
    
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        isStaff.layer.cornerRadius = isStaff.frame.height / 2
        userID.text = "\(row)"
    }
}
