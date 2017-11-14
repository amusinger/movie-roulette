//
//  ViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/23/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import UIKit
public typealias CompletionClosure = (_ res: AnyObject?) -> Void
class ViewController: UIViewController {

    var randomMovie: Movie? = nil
    var genres: [Genre] = []
    var year = ""
    var score = ""
    var genre = ""
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.getGenres()
        print("after getGenres ", self.randomMovie?.original_title as Any)
    }
    
    func getGenres(){
        APIManager.getGenres(){
            (result) in
            self.genres = result
        
            self.pressButton() //remove later
        }
    }
    
    func pressButton(){
        if(!self.genres.isEmpty){
            self.activityLoader()
            self.fetchMovie { (success) -> Void in
                if success {
                    // do second task if success
                    self.showMovie()
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                else{
                    print("smth went wrong")
                    self.reset()
                }
            }
        }
        else{
            print("couldn't load genres")
        }
    }
    
    func reset(){
        self.year = ""
        self.score = ""
        self.genre = ""
    }
    
    func activityLoader(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func fetchMovie(completion: @escaping (_ success: Bool) -> Void) {
            // Do something
        APIManager.getMovies(year: year, score: score, genre: genre, genres: self.genres) {
            (result) in
            self.randomMovie = result as? Movie
            print("findMovie ", self.randomMovie?.original_title as Any)
            if((self.randomMovie != nil) && (!self.genres.isEmpty)){
                // self.matchMoviewWithGenres()
                print("findMovie return", self.randomMovie?.original_title as Any)
           
                for genre in self.genres{
                    for id in (self.randomMovie?.genre_ids)!{
                        if(genre.id == id){
                            self.randomMovie?.genres.append(genre.name)
                        }
                    }
                }
                 completion(true)
            }
            if(self.randomMovie == nil){
                print("request is too unique like you")
                completion(false)
            }
            
        }
        
        completion(false)
    }
    
    func showMovie(){
        print("-------second task------")
        print(self.randomMovie?.original_title)
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
//        VC.movie = self.randomMovie
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    

    
//    func matchMoviewWithGenres(){
//        for genre in self.genres{
//            for id in (self.randomMovie?.genre_ids)!{
//                if(genre.id == id){
//                    self.randomMovie?.genres.append(genre.name)
//                    print("matchMoviewWithGenres ", self.randomMovie?.genres as Any)
//
//                }
//            }
//        }
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

