//
//  UserTableViewCell.swift
//  ECS_ATL_Practical_Test
//
//  Created by Wei Jen Wang on 2022/8/25.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameTop: UILabel!
    @IBOutlet weak var userNameMid: UILabel!
    @IBOutlet weak var siteAdminBadge: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userAvatar.layer.cornerRadius = userAvatar.frame.height / 2
        siteAdminBadge.layer.cornerRadius = siteAdminBadge.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configTheCell(details: UserListDetails, sn: Int) {
        userNameTop.isHidden = !details.site_admin
        siteAdminBadge.isHidden = !details.site_admin
        userNameMid.isHidden = details.site_admin
        
        let url = URL(string: details.avatar_url)
        userAvatar.kf.setImage(with: url)
        
        userNameTop.text = "\(sn) " + details.login
        userNameMid.text = "\(sn) " + details.login
    }
}
