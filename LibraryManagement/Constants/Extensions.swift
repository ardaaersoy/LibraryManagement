//
//  Extensions.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import UIKit
import Kingfisher

// MARK: -
extension UIImageView {
    func setKfImage(url: URL) {
        self.kf.setImage(with: url)
    }
}
