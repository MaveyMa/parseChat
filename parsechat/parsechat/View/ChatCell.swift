//
//  ChatCell.swift
//  parsechat
//
//  Created by Mavey Ma on 2/26/18.
//  Copyright © 2018 Mavey Ma. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
  
  @IBOutlet weak var chatTextLabel: UILabel!
  @IBOutlet weak var authorTextLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
