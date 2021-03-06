//
//  ViewController.swift
//  Github-UserList-Texture
//
//  Created by 조우진 on 01/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit
import SnapKit
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
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
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
        self.node.delegate = self
        self.node.dataSource = self
        self.node.allowsSelection = false
        
        self.node.view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.left.right.equalTo(self.node.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.node.view.safeAreaLayoutGuide.snp.bottom)
        }
        
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
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchString)
            .disposed(by: disposeBag)
        
        viewModel.userList.asObservable()
            .subscribe(onNext: { [weak self] data in
                guard let strongSelf = self else { return }
                strongSelf.userlist = data
                strongSelf.node.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
    func loadMoreData(_ context: ASBatchContext?){
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
        
        _ = Api().loadMoreRequest().asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .retry(3)
            .subscribe(onNext: { [weak self] data in
                guard let strongSelf = self else { return }
                
                let moreDataIndex = data.enumerated()
                    .map{ offset, element -> IndexPath in
                        return IndexPath(row: strongSelf.userlist.count - 1 + offset, section: 0)
                }
                
                strongSelf.userlist.append(contentsOf: data)
                strongSelf.node.performBatchUpdates({
                    strongSelf.node.insertRows(at: moreDataIndex, with: .none)
                }, completion: { isFinish in
                    context?.completeBatchFetching(isFinish)
                    strongSelf.loadingIndicator.stopAnimating()
                })
                
                context?.completeBatchFetching(true)
                }, onError: { error in
                    context?.completeBatchFetching(true)
                    self.loadingIndicator.stopAnimating()
            })
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
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        if userlist.isEmpty { return false }
        else if loadingIndicator.isAnimating { return false }
        else if UserDefaults.standard.value(forKey: "nextLink") as! String == "" { return false }
        else { return true }    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        loadMoreData(context)
    }
}
