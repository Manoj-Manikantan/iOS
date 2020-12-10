//
//  TrackingScreenViewController.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-10.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import UIKit

class TrackingScreenViewController: UIViewController {
    
    
    @IBOutlet weak var TableViewBMI: UITableView!
    
    var listItems = [BMIListModel]()
    
}

extension TrackingScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemTableViewCell
        cell?.lblWeight.text = "\(listItems[indexPath.row].weight)"
        cell?.lblBMI.text = "\(listItems[indexPath.row].BMIValue)"
        cell?.lblDate.text = "\(listItems[indexPath.row].dateStr)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
}
