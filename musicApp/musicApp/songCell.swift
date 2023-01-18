//
//  songCell.swift
//  musicApp
//
//  Created by Cubastion on 18/01/23.
//

import UIKit

class songCell: UITableViewCell {
    @IBOutlet weak var viewThing: UIView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewThing.layer.borderColor = UIColor.black.cgColor
        viewThing.layer.borderWidth = 2
        viewThing.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        // Configure the view for the selected state
    }
    
}
