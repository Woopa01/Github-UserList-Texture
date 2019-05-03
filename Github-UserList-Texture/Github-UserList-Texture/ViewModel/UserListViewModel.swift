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

class UserListViewModel {
    //Input
    let searchString = BehaviorRelay<String>(value: "")
    
    //Output
    let userList: Driver<[UserModel]>
   
    
    struct Dependencies {
        let api: Api
    }
    
    private let dependencies = Dependencies(api: Api())
    
    init(userModel : UserModel) {
        self.userList = searchString.asObservable()
            .flatMap({ (String) in
                self.dependencies.api.searchRequest()
            })
            .map({ items -> [UserModel] in
                return items
            })
            .asDriver(onErrorJustReturn: [])
    }
}
