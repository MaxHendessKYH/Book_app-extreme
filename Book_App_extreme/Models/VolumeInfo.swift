//
//  VolumeInfo.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-28.
//

import Foundation
struct VolumeInfo: Codable{
    let title: String
    let authors: [String]?
    let description: String?
    let publishedDate: String?
    let categories: [String]?
    let pageCount: Int?
    let language: String?
}
