//
//  RepositoryTableViewCell.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import UIKit


class RepositoryCell: UITableViewCell {
    
    static let reuseID = "Repository Cell identifier"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsAmountLabel: UILabel!
    
    func configureCell() {
        
    }
}
