import UIKit

class MovieCollectionViewCell: UICollectionViewCell, MoviesViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    func display(name: String) {
        self.name.text = name
    }
    
    func display(genres: String) {
        self.genres.text = genres
    }
    
    func display(poster: UIImage?) {
        self.poster.image = poster
    }
    
    func display(releaseDate: String) {
       self.releaseDate.text = releaseDate
    }
    
}
