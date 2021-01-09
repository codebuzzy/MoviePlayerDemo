//
//  MovieTableViewCell.swift
//  MoviePlayerDemo
//
//  Created by Malti Maurya on 08/01/21.
//  Copyright © 2021 Malti Maurya. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
