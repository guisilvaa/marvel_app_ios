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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: CharacterItemCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterItemCell.IDENTIFIER)
        self.tableView.register(UINib(nibName: EmptyViewCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: EmptyViewCell.IDENTIFIER)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.searchBar.placeholder = "CHARACTER_SEARCH_PLACEHOLDER".localized()
        self.searchBar.delegate = self
        
        self.viewModel.delegate = self
        self.viewModel.loadCharacters()
        
        setupInfiniteScroll()
    }
    
    private func setupInfiniteScroll() {
        self.tableView.addInfiniteScroll { (_) in
            self.viewModel.loadCharacters()
        }
        
        self.tableView.setShouldShowInfiniteScrollHandler { (_) -> Bool in
            return self.viewModel.hasMoreCharacters
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.loadCharacters(query: "")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        self.viewModel.loadCharacters(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.loadCharacters(query: "")
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func onCharactersLoaded() {
        self.tableView.finishInfiniteScroll()
        self.tableView.reloadData()
    }
    
    func onCharactersError(error: KakoError?) {
        
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.characters.count //5//self.notifications.isEmpty ? 1 : self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        /*if notifications.isEmpty {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.IDENTIFIER, for: indexPath) as! EmptyViewCell
            itemCell.fillCell(color: UIColor.turquoiseGreen, icon: UIImage(named: "icFlagEmptyView")!, message: "TIMELINE_EMPTY_MESSAGE".localized())
            cell = itemCell
        }
        else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: NotificationItemCell.IDENTIFIER, for: indexPath) as! NotificationItemCell
            itemCell.fillCell(notification: notifications[indexPath.row])
            cell = itemCell
        }*/
        
        let itemCell = tableView.dequeueReusableCell(withIdentifier: CharacterItemCell.IDENTIFIER, for: indexPath) as! CharacterItemCell
        let character = self.viewModel.characters[indexPath.row]
        itemCell.fillCell(character: character, isFavorite: false)
        cell = itemCell
        
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
        
    }
}
