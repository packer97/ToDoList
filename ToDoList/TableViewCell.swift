//
//  TableViewCell.swift
//  ToDoList
//
//  Created by MyPC on 03.11.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
