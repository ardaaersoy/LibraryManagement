//
//  ViewController.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func loadData() {
        if let path = Bundle.main.path(forResource: "BookStore", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let books = try JSONDecoder().decode([BookModel].self, from: data)
                
                for book in books {
                    print(book)
                }
                
                insertBooks(books)
                
            } catch let err {
                print("err", err)
            }
        }
    }
    
    private func insertBooks(_ books: [BookModel]) {
        for book in books {
            Database.shared.insertBook(book: book) { isInserted in
                if isInserted {
                    print("\(book.ISBN) is inserted.")
                }
            }
        }
    }
    
    private func fetchData() {
        Database.shared.fetchData(entity: Keys.init().BOOK_DB) { (allBooks: [Book]?) in
            guard let books = allBooks else { print("none"); return }
            
            if !books.isEmpty {
                self.books = books
            } else {
                self.loadData()
            }
        }
    }
}

