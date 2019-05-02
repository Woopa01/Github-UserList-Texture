//
//  ApiResponses.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
struct UserListResponse: Codable{
    let userlist: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case userlist = "items"
    }
}
