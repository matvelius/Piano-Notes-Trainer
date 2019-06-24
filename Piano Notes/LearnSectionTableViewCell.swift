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
    
    func updateCell(with lesson: [String], lessonID: Int, imageIndex: Int) {
        lessonTitle.text = lesson[0].uppercased()
        lessonSubtitle.text = lesson[1]
        
        if lessonsCompleted.contains(lessonID) {
            lessonImage.image = UIImage(named: "level_complete")
        } else {
            lessonImage.image = UIImage(named: "lesson\(imageIndex)img")
        }
        
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
