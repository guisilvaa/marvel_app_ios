//
//  CharacterAppearencesCell.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 07/08/21.
//

import UIKit

class CharacterAppearencesCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var comicsLabel: UILabel!
    
    @IBOutlet weak var storiesLabel: UILabel!
    
    @IBOutlet weak var eventsLabel: UILabel!
    
    @IBOutlet weak var seriesLabel: UILabel!
    
    static let IDENTIFIER = "CharacterAppearencesCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.text = "CHARACTER_DETAILS_APPEARS_IN".localized()
    }

    func fillCell(character: Character) {
        let comics = character.comics?.available ?? 0
        let stories = character.stories?.available ?? 0
        let events = character.events?.available ?? 0
        let series = character.series?.available ?? 0
        
        self.comicsLabel.text = comics > 0 ? String(format: "CHARACTER_DETAILS_COMICS_COUNT".localized(), comics) : nil
        self.storiesLabel.text = stories > 0 ? String(format: "CHARACTER_DETAILS_STORIES_COUNT".localized(), stories) : nil
        self.eventsLabel.text = events > 0 ? String(format: "CHARACTER_DETAILS_EVENTS_COUNT".localized(), events) : nil
        self.seriesLabel.text = series > 0 ? String(format: "CHARACTER_DETAILS_SERIES_COUNT".localized(), series) : nil
    }
}
