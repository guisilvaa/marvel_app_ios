//
//  CharactersViewController.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 06/08/21.
//

import UIKit
import Kako

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = CharactersViewModel()
    
    private let CHARACTER_DETAILS_SEGUE = "CHARACTER_DETAILS_SEGUE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: CharacterItemCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterItemCell.IDENTIFIER)
        self.tableView.register(UINib(nibName: EmptyViewCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: EmptyViewCell.IDENTIFIER)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.searchBar.searchTextField.backgroundColor = .lightGrey
        self.searchBar.placeholder = "CHARACTER_SEARCH_PLACEHOLDER".localized()
        self.searchBar.delegate = self
        
        self.viewModel.delegate = self
        self.viewModel.loadCharacters()
        
        setupInfiniteScroll()
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteCharacterChanged(_:)), name: .favoriteCharacter, object: nil)
    }
    
    private func setupInfiniteScroll() {
        self.tableView.addInfiniteScroll { (_) in
            self.viewModel.loadCharacters()
        }
        
        self.tableView.setShouldShowInfiniteScrollHandler { (_) -> Bool in
            return self.viewModel.hasMoreCharacters
        }
    }
    
    @objc func favoriteCharacterChanged(_ notification: Notification) {
        if let character = notification.object as? Character,
           let _ = self.viewModel.characters.firstIndex(where: { $0.id == character.id }) {
            self.tableView.reloadData()
        }
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

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.loadCharacters(query: "")
            
            DispatchQueue.main.async { [weak self] in
                        guard let self = self else{ return }
                        self.searchBar.resignFirstResponder()
                    }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        self.viewModel.loadCharacters(query: query)
        searchBar.resignFirstResponder()
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func onCharactersLoaded() {
        self.tableView.finishInfiniteScroll()
        self.tableView.reloadData()
    }
    
    func onCharactersError(error: KakoError?) {
        showErrorMessage(error: error)
        self.tableView.finishInfiniteScroll()
        self.tableView.reloadData()
    }
}

extension CharactersViewController: CharacterItemCellDelegate {
    func onFavoriteCharacter(character: Character) {
        self.viewModel.saveFavorite(character: character)
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.characters.isEmpty ? 1 : self.viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if self.viewModel.characters.isEmpty {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.IDENTIFIER, for: indexPath) as! EmptyViewCell
            if self.viewModel.hasError {
                itemCell.fillCell(error: self.viewModel.error)
                itemCell.buttonAction = {
                    self.viewModel.loadCharacters(query: self.searchBar.text)
                }
            }
            else {
                itemCell.fillCell(color: UIColor.greyishBrown, icon: UIImage(systemName: "person.circle")!, message: "CHARACTERS_EMPTY_MESSAGE".localized())
            }
            cell = itemCell
        }
        else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: CharacterItemCell.IDENTIFIER, for: indexPath) as! CharacterItemCell
            let character = self.viewModel.characters[indexPath.row]
            itemCell.fillCell(character: character, isFavorite: self.viewModel.isFavorite(character: character))
            itemCell.delegate = self
            cell = itemCell
        }
        
        return cell!
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.viewModel.characters.isEmpty {
            let character = self.viewModel.characters[indexPath.row]
            self.performSegue(withIdentifier: CHARACTER_DETAILS_SEGUE, sender: character)
        }
    }
}
