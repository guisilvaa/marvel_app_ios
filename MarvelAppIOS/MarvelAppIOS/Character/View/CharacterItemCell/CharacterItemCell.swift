//
//  CharacterItemCell.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 06/08/21.
//

import UIKit

protocol CharacterItemCellDelegate {
    func onFavoriteCharacter(character: Character)
}

class CharacterItemCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var infoStackVIew: UIStackView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var delegate: CharacterItemCellDelegate?
    
    private var character: Character!
    
    static let IDENTIFIER = "CharacterItemCell"
    
    func fillCell(character: Character, isFavorite: Bool)  {
        self.character = character
        
        self.avatarImageView.loadImage(url: character.thumbImage?.imagePath ?? "")
        
        self.nameLabel.text = character.name
        self.descriptionLabel.text = character.description
        self.favoriteButton.setImage(isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        self.favoriteButton.tintColor = UIColor.primaryColor
    }

    @IBAction func onFavoriteClicked(_ sender: UIButton) {
        self.delegate?.onFavoriteCharacter(character: self.character)
    }
    
}
