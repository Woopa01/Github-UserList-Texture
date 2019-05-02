//
//  UserListCellNode.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 02/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit

class UserListCellNode : ASCellNode {
    lazy var userprofileNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 50, height: 50)
        node.cornerRadius = 25.0
        node.borderWidth = 0.5
        node.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return node
    }()
    
    lazy var usernameNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var scoreNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    override init() {
        super.init()
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
    }
}

extension UserListCellNode {
    var usernameNodeAttribute: [NSAttributedString.Key : Any] {
        return [.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                .foregroundColor: UIColor.black]
    }
    
    var scoreNodeAttribute: [NSAttributedString.Key : Any] {
        return [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor.gray]
    }
}

extension UserListCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textContentLayout = textContentStackLayout()
        textContentLayout.style.flexShrink = 1.0
        textContentLayout.style.flexGrow = 1.0
        
        let cellStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 5.0,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [userprofileNode,textContentLayout])
        
        return ASInsetLayoutSpec(insets:.init(top: 25.0,
                                              left: 25.0,
                                              bottom: 25.0,
                                              right: 25.0),
                                 child: cellStackLayout)
    }
    
    func textContentStackLayout() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 3.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [usernameNode, scoreNode])
    }
}