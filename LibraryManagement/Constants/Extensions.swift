//
//  Extensions.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import UIKit
import Kingfisher

// MARK: - UIImageview extension to set image from url
extension UIImageView {
    func setKfImage(url: String?) {
        guard let url = URL(string: url ?? "https://www.urbansplash.co.uk/images/placeholder-1-1.jpg") else { return }
        self.kf.setImage(with: url)
    }
}
