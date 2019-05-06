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
    func searchRequest(searchString: String) -> Observable<[UserModel]>
//    func loadMoreRequest(nextLink: String) -> Observable<[UserModel]>
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
    private let baseURL = "https://api.github.com"
    private var links = ""
    
    func searchRequest(searchString: String) -> Observable<[UserModel]> {
        return client.get(url: baseURL + Path.searchUser.path(), params: ["q":searchString])
            .map({ res, data -> [UserModel] in
                self.links = res.allHeaderFields["Link"] as? String ?? ""
                
//                dump(res)
//                dump(data)

                guard let response = try? JSONDecoder().decode(UserListResponse.self, from: data)
                else {
                    print("왜 안돼 ㅜㅜㅜㅜ")
                    return []
                }
                               
                return response.userlist
            })
        
    }
//    func loadMoreRequest(nextLink: String) -> Observable<[UserModel]> {
//
//    }
    
}
