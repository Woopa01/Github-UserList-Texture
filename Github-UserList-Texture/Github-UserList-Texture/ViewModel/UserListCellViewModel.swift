//
//  UserListCellViewModel.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 03/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserListCellViewModel{
    
    //Output
    let userProfileURL: Driver<URL?>
    let userName: Driver<String?>
    let score: Driver<String?>
    
    init(userModel: UserModel) {
        self.userProfileURL = Observable.just(userModel.userProfileURL)
            .asDriver(onErrorJustReturn: URL(string: ""))
        
        self.userName = Observable.just(userModel.userName)
            .asDriver(onErrorJustReturn: "")
        
        self.score = Observable.just(String(userModel.score))
            .asDriver(onErrorJustReturn: "")
    }
}
