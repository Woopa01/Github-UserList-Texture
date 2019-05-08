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
    let userProfileURL: Observable<URL?>
    let userName: Observable<String?>
    let score: Observable<String?>
    
    init(userModel: UserModel) {
        self.userProfileURL = Observable.just(userModel.userProfileURL)
        
        self.userName = Observable.just(userModel.userName)
        
        self.score = Observable.just(String(userModel.score))
        
        print("fdsa\(self.userProfileURL)")
    }
}
