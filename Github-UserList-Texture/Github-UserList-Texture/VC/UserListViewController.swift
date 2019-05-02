//
//  ViewController.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 01/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

class UserListViewController: ASViewController<ASTableNode> {
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.placeholder = "Search"
        return bar
    }()
    
    init() {
        let tableNode = ASTableNode(style: .plain)
        tableNode.automaticallyManagesSubnodes = true
        tableNode.backgroundColor = .white
        super.init(node: tableNode)

        self.node.onDidLoad { node in
            guard let tableNode = node as? ASTableNode else { return }
            tableNode.view.separatorStyle = .none
            self.navigationItem.titleView = self.searchBar
        }
        self.node.leadingScreensForBatching = 2.0
        self.node.allowsSelectionDuringEditing = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

