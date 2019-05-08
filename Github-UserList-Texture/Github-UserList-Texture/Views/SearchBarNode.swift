//
//  SearchBarNode.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit

class SearchBarNode: ASDisplayNode {
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let searchBar = UISearchBar(frame: .zero)
            searchBar.placeholder = "search"
            searchBar.searchBarStyle = .minimal
            return searchBar
        }
        
        self.backgroundColor = .gray
    }
}
