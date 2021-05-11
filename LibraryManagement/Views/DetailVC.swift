//
//  DetailVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 2.05.2021.
//

import UIKit

class DetailVC: UIViewController {

    // MARK: -
    var book: Book?
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = book {
            print(book)
        }
    }
}
