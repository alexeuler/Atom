//
//  MainCell.swift
//  Atom
//
//  Created by Алексей Карасев on 18/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell, AtomComponent {
    
    struct Props {
        let key: Int
        let title: String
        let status: Bool
    }
    
    var props: Props! {
        didSet {
            render()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    
    func render() {
        guard props != nil else { return }
        titleLabel.text = props.title
        statusSwitch.on = props.status
        statusLabel.text = props.status ? "On" : "Off"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchClicked(sender: AnyObject) {
        guard props != nil else { return }
        Actions.instance.toggleTodo(props.key)
    }
}
