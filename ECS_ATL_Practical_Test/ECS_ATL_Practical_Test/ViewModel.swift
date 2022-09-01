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
    
    let fetchPaging = PublishSubject<Void>()
    let userList = BehaviorRelay<[UserListDetails]>(value: [])
    
    private var lastId: Int = 0
    private var perPage: Int = 20
    private let maxCapacity: Int = 100
    
    init() {
        if !useMock {
            fetchPaging.subscribe { [weak self] _ in
                guard let self = self else { return }
                self.fetchUserListWithPaging()
            }.disposed(by: disposeBag)
        }
    }
    
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
    
    func fetchUserListWithPaging() {
        let stub = MoyaProvider<GithubServices>.neverStub // online only
        let provider = MoyaProvider<GithubServices>(stubClosure: stub)
        return provider.rx.request(.GetUserListPage(since: lastId, perPage: perPage)).subscribe { [self] event in
                switch event {
                case .success(let res):
                    guard let userListData = try? JSONDecoder().decode(UserList.self, from: res.data) else {
                        print("no data")
                        return
                    }
                    
                    let currentList = userList.value
                    lastId = userListData.users.last?.id ?? 1
                    
                    userList.accept(currentList + userListData.users)
                case .failure(let err):
                    print(err)
                }
        }.disposed(by: disposeBag)
    }
}
