//
//  ViewModel.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import Foundation

class ViewModel {
    
    private(set) var allPosts = [Post]()
    var reloadView: (() -> ())?
    private(set) var cachedPost: [Int: Post] = [:]
    
    func postAPICall(_ currentPageIndex: Int) {
        APIService.shared.apiCallWithCurrentPageIndex(currentPageIndex) { [weak self] result in
            switch (result) {
                case .success(let posts):
                    self?.allPosts.append(contentsOf: posts)
                    DispatchQueue.main.async {
                        self?.reloadView?()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func updateCachedPost(for post: Post) {
        cachedPost[post.id] = post
    }
    
}
