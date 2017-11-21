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
    
    var movie: Movie? = nil
    var wishlist = Wishlist()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("showmovie ", movie?.original_title as Any)
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
