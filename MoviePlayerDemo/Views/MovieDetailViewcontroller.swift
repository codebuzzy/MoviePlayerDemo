//
//  MovieDetailViewcontroller.swift
//  MoviePlayerDemo
//
//  Created by Malti Maurya on 08/01/21.
//  Copyright © 2021 Malti Maurya. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieDetail : Movie?
    
    @IBOutlet weak var votingCount: UILabel!
    @IBOutlet weak var votingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var originalMovieName: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var movieTypeLabel: UILabel!
    
    //MARK : OverriddeN Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func loadData(){
        if  movieDetail != nil
        {
            posterImageview.downloaded(from: Constants.imageURL + movieDetail!.posterPath)
            originalMovieName.text = movieDetail!.originalTitle
            movieNameLabel.text = movieDetail!.title
            overviewLabel.text = movieDetail!.overview
            genreLabel.text = movieDetail!.originalLanguage.rawValue
            releaseDateLabel.text = movieDetail!.releaseDate
            votingCount.text = String(movieDetail!.voteCount)
            votingLabel.text = String(movieDetail!.voteAverage)
            if (movieDetail!.adult)
            {
                movieTypeLabel.text = "(A)"

            }else{
                 movieTypeLabel.text = "(U)"
            }
            
        }else{
            
        }
    }
}
