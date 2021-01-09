//
//  MovieListViewControllerViewModel.swift
//  MoviePlayerDemo
//
//  Created by Malti Maurya on 08/01/21.
//  Copyright © 2021 Malti Maurya. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol MovieListViewControllerViewModelProtocol {
    var alertMessage: Dynamic<AlertMessage> { get set }
    var response: Dynamic<MoviesResponse?> { get set }
    func serviceRequest(apiName : EndPointType)
    func failTest()
   

}

class MovieListViewControllerViewModel: NSObject, MovieListViewControllerViewModelProtocol {

    
        // MARK: - Vars & Lets
    var alertMessage: Dynamic<AlertMessage> = Dynamic(AlertMessage(title: "", body: ""))
    var response: Dynamic<MoviesResponse?>  = Dynamic(nil)
    private let apiManager = Apimanager(sessionManager: SessionManager(), retrier: APIManagerRetrier())
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    
    // MARK: - Public methods
    func serviceRequest(apiName : EndPointType) {
        
        
        self.apiManager.call(type: apiName){(res: Result<MoviesResponse?>) in
            switch res
            {
            case .success(let response):
                 self.response.value = response
                 self.openDatabse(movieObj: response!)
                break
            case .failure(let message):
                self.alertMessage.value = message as! AlertMessage
                break
            }
        }
  
    }
    
    
    
    func failTest() {
        self.apiManager.call(type: RequestItemsType.fail) { (res:Result<[String : Any]>) in
            switch res {
            case .success(let response):
                print(response)
                break
            case .failure(let message):
             print(message.localizedDescription)
             self.alertMessage.value = message as! AlertMessage
                break
            }
        }
        
    }
    
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse(movieObj:MoviesResponse)
       {
           context = appDelegate.persistentContainer.viewContext
           let entity = NSEntityDescription.entity(forEntityName: "MovieList", in: context)
           let movieList = NSManagedObject(entity: entity!, insertInto: context)
            
            for index in 0 ..< movieObj.results.count
            {
                let movie = movieObj.results[index]
                saveData(MovieDBObj:movieList, movieData: movie)
            }
           
       }

    func saveData(MovieDBObj:NSManagedObject,movieData : Movie )
       {
        MovieDBObj.setValue(movieData.id, forKey: "id")
        MovieDBObj.setValue(movieData.adult, forKey: "adult")
        MovieDBObj.setValue(movieData.backdropPath, forKey: "backdrop_path")
        MovieDBObj.setValue(movieData.overview, forKey: "overview")
        MovieDBObj.setValue(movieData.posterPath, forKey: "poster_path")
        MovieDBObj.setValue(movieData.title, forKey: "title")
        MovieDBObj.setValue(movieData.voteAverage, forKey: "vote_average")
        MovieDBObj.setValue(movieData.voteCount, forKey: "vote_count")

           print("Storing Data..")
           do {
               try context.save()
           } catch {
               print("Storing data Failed")
           }

           fetchData()
       }

       func fetchData()
       {
           print("Fetching Data..")
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieList")
           request.returnsObjectsAsFaults = false
           do {
               let result = try context.fetch(request)
               for data in result as! [NSManagedObject] {
                   let title = data.value(forKey: "title") as! String
                   let overview = data.value(forKey: "overview") as! String
                   print("Movie Name is : "+title+" and overview is : "+overview)
               }
           } catch {
               print("Fetching data Failed")
           }
       }
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
}

 
