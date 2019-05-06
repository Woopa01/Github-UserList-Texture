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
    func get(url: String, params: Parameters) -> Observable<(HTTPURLResponse,Data)>
}

class Client: ClientType {

    func get(url: String, params: Parameters) -> Observable<(HTTPURLResponse,Data)> {
        return requestData(.get,
                           url,
                           parameters: params,
                           encoding: URLEncoding.queryString,
                           headers: nil)
    }
}



