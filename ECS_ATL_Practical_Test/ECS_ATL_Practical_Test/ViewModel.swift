//
//  ViewModel.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/29.
//

import UIKit

import Moya
import RxMoya
import RxSwift
import RxRelay

class ViewModel {
    let useMock = Bundle.main.infoDictionary?["Mock Mode"] as? String == "1"
    
    private let disposeBag = DisposeBag()
}
