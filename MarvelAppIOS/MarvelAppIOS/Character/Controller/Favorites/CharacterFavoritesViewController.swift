//
//  CharacterFavoritesViewController.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 08/08/21.
//

import UIKit

class CharacterFavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CharacterFavoritesViewModel()
    
    private let CHARACTER_DETAILS_SEGUE = "CHARACTER_FAVORITE_DETAILS_SEGUE"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: CharacterItemCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterItemCell.IDENTIFIER)
        self.tableView.register(UINib(nibName: EmptyViewCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: EmptyViewCell.IDENTIFIER)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.viewModel.delegate = self
        self.viewModel.loadFavorites()
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteCharacterChanged(_:)), name: .favoriteCharacter, object: nil)
    }
    
    @objc func favoriteCharacterChanged(_ notification: Notification) {
        self.viewModel.loadFavorites()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CHARACTER_DETAILS_SEGUE {
            let viewController = segue.destination as! CharacterDetailsViewController
            viewController.character = (sender as! Character)
        }
    }

}

extension CharacterFavoritesViewController: CharacterFavoriteViewModelDelegate {
    func onFavoritesLoaded() {
        self.tableView.reloadData()
    }
}

extension CharacterFavoritesViewController: CharacterItemCellDelegate {
    func onFavoriteCharacter(character: Character) {
        self.viewModel.deleteFavorite(character: character)
    }
}

extension CharacterFavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.favorites.isEmpty ? 1 : self.viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if self.viewModel.favorites.isEmpty {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.IDENTIFIER, for: indexPath) as! EmptyViewCell
            itemCell.fillCell(color: UIColor.greyishBrown, icon: UIImage(systemName: "star")!, message: "CHARACTER_FAVORITES_EMPTY_MESSAGE".localized())
            cell = itemCell
        }
        else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: CharacterItemCell.IDENTIFIER, for: indexPath) as! CharacterItemCell
            let character = self.viewModel.favorites[indexPath.row]
            itemCell.fillCell(character: character, isFavorite: true)
            itemCell.delegate = self
            cell = itemCell
        }
        
        return cell!
    }
}

extension CharacterFavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.viewModel.favorites.isEmpty {
            let character = self.viewModel.favorites[indexPath.row]
            self.performSegue(withIdentifier: CHARACTER_DETAILS_SEGUE, sender: character)
        }
    }
}
