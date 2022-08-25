//
//  UserTableViewCell.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameTop: UILabel!
    @IBOutlet weak var userNameMid: UILabel!
    @IBOutlet weak var siteAdminBadge: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
