//
//  RecordTableViewCell.swift
//  MintPush
//
//  Created by Gokhan Gultekin on 17/08/2017.
//  Copyright © 2017 Peakode. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var roundedView: UIView?

    @IBOutlet var lineTop: UIView?
    @IBOutlet var lineBottom: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView?.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
