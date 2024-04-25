//
//  DataModel.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
