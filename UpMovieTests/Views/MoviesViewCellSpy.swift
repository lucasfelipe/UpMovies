import UIKit
@testable import UpMovie

class MoviesViewCellSpy: MoviesViewCell {
    var name: String = ""
    var genres: String = ""
    var poster: UIImage? = nil
    var releaseDate: String = ""
    
    init() {
    }
    
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
}
