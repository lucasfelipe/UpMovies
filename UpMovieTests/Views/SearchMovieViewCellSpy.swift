import UIKit
@testable import UpMovie

class SearchMovieViewCellSpy: SearchMovieViewCell {
    var name: String = ""
    var genres: String = ""
    var poster: UIImage? = nil
    
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
}
