//
//  FestivalCellTableViewCell.swift
//  TeamFestive
//
//  Created by Xia, Emily on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class FestivalCellTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var ListImage: UIImageView!
    @IBOutlet weak var ListName: UILabel!
    @IBOutlet weak var ListDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
