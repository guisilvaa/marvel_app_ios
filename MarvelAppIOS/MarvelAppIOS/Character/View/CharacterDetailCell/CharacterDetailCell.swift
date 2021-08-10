//
//  CharacterDetailCell.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 07/08/21.
//

import UIKit

class CharacterDetailCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var character: Character!
    
    static let IDENTIFIER = "CharacterDetailCell"
    
    func fillCell(character: Character)  {
        self.character = character
        
        self.avatarImageView.loadImage(url: character.thumbImage?.imagePath ?? "")
        
        self.nameLabel.text = character.name
        self.descriptionLabel.text = character.description
    }
}
