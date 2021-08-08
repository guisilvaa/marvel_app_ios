//
//  EmptyViewCell.swift
//  Gamefic
//
//  Created by Guilherme Silva on 14/08/19.
//  Copyright © 2019 Gamefic. All rights reserved.
//

import UIKit
import Kako

class EmptyViewCell: UITableViewCell {

    @IBOutlet weak var emptyImageView: UIImageView!
    
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var buttonAction: (() -> Void)?
    
    static let IDENTIFIER = "EmptyViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.button.isHidden = true
        self.button.setTitle("TRY_AGAIN".localized(), for: .normal)
    }
    
    func fillCell(color: UIColor, icon: UIImage, message: String) {
        self.emptyImageView.image = icon
        self.emptyMessageLabel.text = message
        self.button.isHidden = true
    }
    
    func fillCell(error: KakoError?) {
        if error?.code == KakoErrorType.connection.rawValue {
            self.emptyImageView.image = UIImage(systemName: "person")
            self.emptyImageView.tintColor = UIColor.marigold
            self.emptyMessageLabel.text = "ERROR_CONECTION_MESSAGE".localized()
        }
        else {
            self.emptyImageView.image = UIImage(systemName: "person")
            self.emptyImageView.tintColor = UIColor.cherryRed
            self.emptyMessageLabel.text = "ERROR_GENERIC_MESSAGE".localized()
        }
        self.button.isHidden = false
    }

    
    @IBAction func onButtonClicked(_ sender: UIButton) {
        buttonAction?()
    }
    
}
