//
//  CharactersViewController.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 06/08/21.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: CharacterItemCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: CharacterItemCell.IDENTIFIER)
        self.tableView.register(UINib(nibName: EmptyViewCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: EmptyViewCell.IDENTIFIER)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.searchBar.placeholder = "CHARACTER_SEARCH_PLACEHOLDER".localized()
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

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//self.notifications.isEmpty ? 1 : self.notifications.count
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
        //itemCell.fillCell(notification: notifications[indexPath.row])
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