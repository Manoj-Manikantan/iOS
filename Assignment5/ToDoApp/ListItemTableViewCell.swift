//
//  ListItemTableViewCell.swift
//  Assignment4
//
//  Created by Manoj on 2020-11-14.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var taskSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
