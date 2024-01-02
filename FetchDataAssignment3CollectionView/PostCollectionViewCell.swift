//
//  PostCollectionViewCell.swift
//  FetchDataAssignment3CollectionView
//
//  Created by Mac on 20/12/23.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var completedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
