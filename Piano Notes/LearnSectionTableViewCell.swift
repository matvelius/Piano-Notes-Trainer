//
//  LearnSectionTableViewCell.swift
//  Piano Notes
//
//  Created by Matvey on 6/22/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class LearnSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var lessonSubtitle: UILabel!
    
    @IBOutlet weak var lessonImage: UIImageView!
    
    func updateCell(with level: Level) {
        lessonTitle.text = level.title.uppercased()
        lessonSubtitle.text = level.subtitle
        lessonImage.image = UIImage(named: "\(level.imageName)")
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
