//
//  RunTableViewCell.swift
//  Run Logger
//
//  Created by Isaac Sheets on 3/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class RunTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentBG: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.sizeToFit()
        milesLabel.sizeToFit()
        timeLabel.sizeToFit()
        paceLabel.sizeToFit()
        
        //round corners of the purple part
        contentBG.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = .black
        
        if selected {
            // Configure the view for the selected state
            contentBG.layer.borderColor = .init(srgbRed: 255, green: 255, blue: 255, alpha: 1.0)
            contentBG.layer.borderWidth = 2
        }
        else {
            contentBG.layer.borderWidth = 0
        }
        
        
    }

}
