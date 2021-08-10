//
//  CharacterDetailsViewController.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 07/08/21.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    
    var character: Character!
    
    private var viewModel: CharacterDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: CharacterDetailCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterDetailCell.IDENTIFIER)
        self.tableView.register(UINib(nibName: CharacterAppearencesCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterAppearencesCell.IDENTIFIER)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200.0
        
        self.viewModel = CharacterDetailViewModel(character: self.character)
        setupFavoriteButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteCharacterChanged(_:)), name: .favoriteCharacter, object: nil)
    }
    
    private func setupFavoriteButton() {
        let icon = self.viewModel.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let favoriteButton = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(onFavoriteClicked))
        self.navigationItem.rightBarButtonItem  = favoriteButton
    }
    
    @objc func favoriteCharacterChanged(_ notification: Notification) {
        setupFavoriteButton()
    }
    
    @objc func onFavoriteClicked(){
        self.viewModel.saveFavorite()
    }
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.row == 0 {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailCell.IDENTIFIER, for: indexPath) as! CharacterDetailCell
            itemCell.fillCell(character: character)
            cell = itemCell
        }
        else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: CharacterAppearencesCell.IDENTIFIER, for: indexPath) as! CharacterAppearencesCell
            itemCell.fillCell(character: character)
            cell = itemCell
        }
        
        return cell!
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
