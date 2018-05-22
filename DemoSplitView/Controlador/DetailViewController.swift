//
//  DetailViewController.swift
//  DemoSplitView
//
//  Created by Gerardo on 20/05/18.
//  Copyright © 2018 Killari. All rights reserved.
//

import UIKit

protocol DetailDelegate: class {
    func updateMovie(newmovie: Movie)
}

class DetailViewController: UIViewController {
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleImage: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    var movie: Movie? {
        didSet {
         setupMovie()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
    }
    func setupMovie() {
        loadViewIfNeeded()
        imageMovie.image = movie?.image
        titleImage.text =  movie?.title
        descriptionMovie.text = movie?.resumen
    }
}

extension DetailViewController: DetailDelegate {
    func updateMovie(newmovie: Movie) {
        self.movie = newmovie
    }
}
