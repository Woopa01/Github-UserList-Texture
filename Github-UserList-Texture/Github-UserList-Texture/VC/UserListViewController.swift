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
import RxCocoa_Texture
import RxOptional

class UserListViewController: ASViewController<ASTableNode> {
    var userlist: [UserModel] = []
    var viewModel: UserListViewModel!
    let disposeBag = DisposeBag()
    
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
        self.node.delegate = self
        self.node.dataSource = self
      
        bindViewModel()
        
    }
    
    override func viewDidLoad() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UserListViewController{
    func bindViewModel(){
        viewModel = UserListViewModel()
        
        searchBar.rx.text
        .orEmpty
        .filterEmpty()
        .distinctUntilChanged()
        .throttle(0.5, scheduler: MainScheduler.instance)
        .bind(to: viewModel.searchString)
        .disposed(by: disposeBag)
        
        viewModel.userList.asObservable()
            .subscribe(onNext: { data in
                self.userlist = data
                self.node.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}

extension UserListViewController: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.userlist.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard self.userlist.count > indexPath.row else { return { ASCellNode() } }
        
        let viewModel = UserListCellViewModel(userModel: self.userlist[indexPath.row])
        
        return {
            let cell = UserListCellNode(viewModel: viewModel)
            return cell
        }
    }
}
