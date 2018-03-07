import UIKit
@testable import UpMovie

class DetailMovieViewSpy: DetailMovieView {
    var name: String = ""
    var genres: String = ""
    var poster: UIImage? = nil
    var releaseDate: String = ""
    var overview: String = ""
    
    init(){}
    
    func display(name: String) {
        self.name = name
    }
    
    func display(genres: String) {
        self.genres = genres
    }
    
    func display(poster: UIImage?) {
        self.poster = poster
    }
    
    func display(releaseDate: String) {
        self.releaseDate = releaseDate
    }
    
    func display(overview: String) {
        self.overview = overview
    }
    
    
}
