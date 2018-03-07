//
//  SearchMovieViewCell.swift
//  UpMovie
//
//  Created by Lucas  Felipe on 06/03/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell, SearchMovieViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    
    func display(name: String) {
        self.name.text = name
    }
    
    func display(genres: String) {
        self.genre.text = genres
    }
    
    func display(poster: UIImage?) {
        self.poster.image = poster
    }
    
    
    

}
