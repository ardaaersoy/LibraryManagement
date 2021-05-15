//
//  DetailVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 2.05.2021.
//

import UIKit
import CoreData
import WebKit

class DetailVC: UIViewController {
    
    // MARK: -
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var assetDetailView: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: -
    var asset: NSManagedObject?
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureElements()
    }
    
    // MARK: -
    private func configureElements() {
        assetDetailView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        if asset is Book {
            guard let book = asset as? Book else { return }
            
            updateUI(hidden: false)
            setBookInfo(book: book)
            
        } else if asset is Video {
            guard let video = asset as? Video else { return }
            
            updateUI(hidden: true)
            loadWebView(url: video.url ?? "")
        }
    }
    
    //MARK: -
    private func setBookInfo(book: Book) {
        bookImageView.setKfImage(url: book.image)
        assetDetailView.text = "\(book.title ?? "") by \(book.author ?? "")\n\n\(book.summary ?? "")"
    }
    
    //MARK: -
    private func updateUI(hidden: Bool) {
        bookImageView.isHidden = hidden
        assetDetailView.isHidden = hidden
        webView.isHidden = !hidden
    }
    
    //MARK: -
    private func loadWebView(url: String) {
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: url)!))
    }
}

// MARK: -
extension DetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString {
            print(url)
        }
        
        decisionHandler(.allow)
    }
}
