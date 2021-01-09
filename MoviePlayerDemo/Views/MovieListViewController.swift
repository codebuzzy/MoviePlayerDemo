//
//  MovieListViewController.swift
//  MoviePlayerDemo
//
//  Created by Malti Maurya on 08/01/21.
//  Copyright © 2021 Malti Maurya. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class MovieListViewController: UIViewController {
    
    
    @IBOutlet weak var movieTableview: UITableView!
    
    // MARK: Variables declearations
      var viewModel : MovieListViewControllerViewModelProtocol?
      var moviearray :  [Movie] = []
      var selectedMovieDetail : Movie?

    //MARK : Overidden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MovieListViewControllerViewModel()
        self.viewModel?.serviceRequest(apiName: RequestItemsType.getMovies)
        self.bindUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "movieDetail" {
                  let vc : MovieDetailViewController = segue.destination as! MovieDetailViewController
               vc.movieDetail = selectedMovieDetail!
           }
           
       }
    
     //MARK : Bind Data to View
    private func bindUI() {
          
          self.viewModel?.alertMessage.bind({ [weak self] in
              self?.showAlertDismissOnly(message: $0)
          })
          
          
          self.viewModel?.response.bind({ [weak self] in
              
              if let response = $0 {
                print(response)
                let movieObject : MoviesResponse = response
                self?.moviearray  = response.results
                self?.movieTableview.reloadData()
                
                
            }
        })
    }


}

//MARK : tableview Delegates & Datasources
extension MovieListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
       cell.movieImageView.downloaded(from: Constants.imageURL + moviearray[indexPath.row].posterPath)

        if(moviearray[indexPath.row].adult)
        {
             cell.nameLabel.text = moviearray[indexPath.row].title + " (A)"
        }else{
             cell.nameLabel.text = moviearray[indexPath.row].title + " (U)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovieDetail = moviearray[indexPath.row]
        performSegue(withIdentifier: "movieDetail", sender: tableView)
        
    }
    
    
    
}

