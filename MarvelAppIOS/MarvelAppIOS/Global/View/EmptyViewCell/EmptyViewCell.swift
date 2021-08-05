//
//  EmptyViewCell.swift
//  Gamefic
//
//  Created by Guilherme Silva on 14/08/19.
//  Copyright © 2019 Gamefic. All rights reserved.
//

import UIKit

class EmptyViewCell: UITableViewCell {

    @IBOutlet weak var emptyImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    static let IDENTIFIER = "EmptyViewCell"
    
    func fillCell(color: UIColor, icon: UIImage, message: String) {
        self.emptyImageView.image = icon
        self.titleLabel.textColor = color
        self.emptyMessageLabel.text = message
    }

}
