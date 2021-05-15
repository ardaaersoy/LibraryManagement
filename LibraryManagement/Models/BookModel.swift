//
//  BookModel.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//

import Foundation

struct BookModel: Decodable {
    let ISBN: String
    let title: String
    let author: String
    let summary: String
    let image: String
    let price: Double
}
