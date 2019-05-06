//
//  Base.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit

//static method or property

extension ASViewController {
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}

func findNextLink(res: HTTPURLResponse) -> String{
    var link = ""
    
    let allLinkString = res.allHeaderFields["Link"] as? String ?? ""
    let allLinkArray = allLinkString
        .filter { $0 != "<" && $0 != ">" }
        .filter { $0 != ";" && $0 != "," }
        .split(separator: " ")
    
    for i in allLinkArray.indices {
        if allLinkArray[i] == "rel=\"next\"" {
            link = String(allLinkArray[i - 1])
        }
    }
    
    return link
}
