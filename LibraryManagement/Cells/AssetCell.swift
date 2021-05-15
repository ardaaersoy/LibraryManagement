//
//  AssetCell.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 11.05.2021.
//

import UIKit

class AssetCell: UITableViewCell {

    @IBOutlet weak var assetTitleLabel: UILabel!
    @IBOutlet weak var assetDescLabel: UILabel!
    @IBOutlet weak var assetSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
