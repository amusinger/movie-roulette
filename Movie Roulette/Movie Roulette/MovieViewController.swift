//
//  MovieViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 11/14/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
   
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overvieTextView: UITextView!
    
    var movie: Movie? = nil
    var wishlist = Wishlist()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("showmovie ", movie?.original_title as Any)
        
    
        
        
        let url = URL(string: ("https://image.tmdb.org/t/p/w300/" + (movie?.poster_path)!))
        if(url != nil){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data!)
                }
            }
        }

        titleLable.text = movie?.original_title
        scoreLabel.text = String(format: "%.1f", (movie?.vote_average)!)
        releaseDate.text?.append((movie?.release_date)!)
        for i in (movie?.genres)!{
            genresLabel.text?.append(" " + i + " ")
        }
        overvieTextView.text = movie?.overview
     
    }
    
    func addToList(){
        wishlist.wishlist.append(movie!)
    }
    
    func openList(){
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "WatchlistViewController") as! WatchlistViewController
        VC.movie = self.movie
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
