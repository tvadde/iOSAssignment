//
//  ViewController.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    var currentPageIndex = 1
    var postDetailsCache: [Int: String] = [:]
    let computationQueue = DispatchQueue(label: "com.example.computation", qos: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of Post"
        viewModel.postAPICall(currentPageIndex)
        viewModel.reloadView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableCell.identifier, for: indexPath) as! PostListTableCell
        let post = viewModel.allPosts[indexPath.row]
        cell.post = post
        
        // Perform heavy computation asynchronously
        let startTime = CFAbsoluteTimeGetCurrent()
        computationQueue.async {
            // Simulate heavy computation
            let endTime = CFAbsoluteTimeGetCurrent()
            let elapsedTime = endTime - startTime
            debugPrint("Heavy computation for ID \(post.id) took \(elapsedTime) seconds")
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            currentPageIndex += 1
            viewModel.postAPICall(currentPageIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = viewModel.allPosts[indexPath.row]
        if let cachedPost = viewModel.cachedPost[post.id] {
            showDetailViewController(with: cachedPost)
        } else {
            viewModel.updateCachedPost(for: post)
            showDetailViewController(with: post)
        }
    }
    
    func showDetailViewController(with post: Post) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsStoryId") as? DetailsViewController else {
            return
        }
        detailViewController.title = "Post Details"
        detailViewController.post = post
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

