//
//  Client.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

protocol ClientType {
    func get(path: String, params: Parameters) -> Observable<(HTTPURLResponse,Data)>
}

class Client: ClientType {
    private let baseURL = "https://api.github.com/"
    
    func get(path: String, params: Parameters) -> Observable<(HTTPURLResponse,Data)> {
        return requestData(.get,
                           baseURL + path,
                           parameters: params,
                           encoding: URLEncoding.queryString,
                           headers: nil)
    }
}



