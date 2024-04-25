//
//  APIService.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func apiCallWithCurrentPageIndex(_  currentPage: Int,  complition: @escaping ((Result<[Post], Error>) -> Void)) {
        
        let url = "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=10"
        // Implement networking to fetch data
        // Example using URLSession:
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            if let err = error {
                complition(.failure(err))
            } else if let data = data {
                do {
                    let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                    complition(.success(fetchedPosts))
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
}
