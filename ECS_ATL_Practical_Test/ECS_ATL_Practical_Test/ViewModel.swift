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
    func fetchUserListAll() -> Observable<[UserListDetails]> {
        return Observable<[UserListDetails]>.create { [self] observer -> Disposable in
            let stub = useMock ? MoyaProvider<GithubServices>.immediatelyStub : MoyaProvider<GithubServices>.neverStub
            let provider = MoyaProvider<GithubServices>(stubClosure: stub)
            return provider.rx.request(.GetUserListDefault).subscribe { event in
                    switch event {
                    case .success(let res):
                        guard let userListData = try? JSONDecoder().decode(UserList.self, from: res.data) else {
                            print("no data")
                            return
                        }
                        
                        observer.onNext(userListData.users)
                        observer.onCompleted()
                    case .failure(let err):
                        print(err)
                    }
            }
        }
    }
}
