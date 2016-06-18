//
//  MainCell.swift
//  Atom
//
//  Created by Алексей Карасев on 18/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    struct Props {
        let key: String
        let title: String
        let status: Bool
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchClicked(sender: AnyObject) {
    }
}
