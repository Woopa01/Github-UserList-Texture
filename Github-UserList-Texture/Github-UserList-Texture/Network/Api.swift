//
//  Api.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PathType {
    func path() -> String
}

protocol APIProvider {
    func searchRequest() -> Observable<[UserModel]>
}

enum Path: PathType{
    case searchUser
    func path() -> String {
        switch self {
        case .searchUser: return "/search/users"
        }
    }
}

class Api: APIProvider{
    private let client = Client()
    
    func searchRequest() -> Observable<[UserModel]> {
        return client.get(path: Path.searchUser.path(),
                          params: ["p": "v"])
            .map({ res, data -> [UserModel] in
                let headers = res.allHeaderFields
                dump(headers)
                dump(headers["Link"])
                guard let response = try? JSONDecoder().decode(UserListResponse.self, from: data)
                else {
                    print("ㅁㄴㅇㄹㅁㄴㅇㄹ")
                    return []
                }
                
                return response.userlist
            })
    }
}
