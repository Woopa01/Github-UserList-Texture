//
//  UserModel.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//
import Foundation

struct UserModel: Codable {
    let userName: String
    let userProfileURL: URL?
    let score: Float
    
    enum CodingKeys: String, CodingKey{
        case userName = "login"
        case userProfileURL = "avatar_url"
        case score
    }
}
