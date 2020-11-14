//
//  ListItemCellTableViewCell.swift
//  MyShoppingList
//
//  Created by Manoj on 2020-10-30.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class ListItemCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textFieldListItem: UITextField!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var stepperQty: UIStepper!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
