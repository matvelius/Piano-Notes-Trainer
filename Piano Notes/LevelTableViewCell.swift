//
//  LevelTableViewCell.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var levelTitle: UILabel!
    
    @IBOutlet weak var levelSubtitle: UILabel!
    
    @IBOutlet weak var levelImage: UIImageView!
    
    func updateCell(with level: Level) {
        levelTitle.text = level.title
        levelSubtitle.text = level.subtitle
        levelImage.image = UIImage(named: "\(level.imageName)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
