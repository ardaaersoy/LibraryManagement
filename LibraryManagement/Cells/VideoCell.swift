//
//  VideoCell.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 11.05.2021.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var videoDirectorLabel: UILabel!
    @IBOutlet weak var videoUrlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
