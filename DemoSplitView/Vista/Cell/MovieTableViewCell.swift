//
//  MovieTableViewCell.swift
//  DemoSplitView
//
//  Created by Gerardo on 20/05/18.
//  Copyright © 2018 Killari. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(movie: Movie) {
        movieImage.image = movie.image
        titleMovie.text = movie.title
    }
    
}
