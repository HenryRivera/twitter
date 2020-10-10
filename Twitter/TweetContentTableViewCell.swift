//
//  TweetContentTableViewCell.swift
//  Twitter
//
//  Created by Henry Rivera on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetContentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
