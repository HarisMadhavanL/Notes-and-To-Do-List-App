//
//  ToDoListTableViewCell.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 10/10/24.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.selectionStyle = .none
    }
    
}
