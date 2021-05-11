//
//  BookCell.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import UIKit

class BookCell: UITableViewCell {

    // MARK: -
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookSummaryLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
