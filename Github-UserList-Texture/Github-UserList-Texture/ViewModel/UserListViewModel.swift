//
//  UserListViewModel.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

class UserListViewModel {
    //Input
    let searchString = BehaviorRelay<String>(value: "")
    
    //Output
    let userList = BehaviorRelay<[UserModel]>(value: [])
   
    let disposeBag = DisposeBag()

    struct Dependencies {
        let api: Api
    }
    
    private let dependencies = Dependencies(api: Api())
    
    init() {
        searchString.asObservable()
        .distinctUntilChanged()
        .flatMap {
                self.dependencies.api.searchRequest(searchString: $0)
        }
        .bind(to: userList)
        .disposed(by: disposeBag)
    }
}
