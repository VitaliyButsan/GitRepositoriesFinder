//
//  RepositoryTableViewCell.swift
//  GitRepositoriesFinder
//
//  Created by vit on 08.12.2020.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
    
    static let reuseID = "RepositoryCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsAmountLabel: UILabel!
    
    func configureCell(with repository: Repository) {
        nameLabel.text = repository.name
        starsAmountLabel.text = "\(repository.stars)"
        guard let urlString = repository.owner.avatarURL,
              let url = URL(string: urlString) else { return }
        iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder")!)
    }
}
