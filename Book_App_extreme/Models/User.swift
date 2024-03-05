//
//  User.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-03-04.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
