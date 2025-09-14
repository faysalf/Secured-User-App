//
//  UserTableViewCell.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let IDENTIFIER = "user_list_tv_cell_identifier"
    
    @IBOutlet weak var userProfileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with user: User) {
        userNameLabel.text = user.fullName
        userEmailLabel.text = user.email
    }
    
    func configureImage(_ image: UIImage) {
        UIView.transition(with: userProfileImgView, duration: 0.5) {
            self.userProfileImgView.image = image
        }
    }
    
}
