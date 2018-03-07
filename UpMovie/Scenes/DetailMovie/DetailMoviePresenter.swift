import UIKit

protocol DetailMovieView: class {
    func display(name: String)
    func display(genres: String)
    func display(poster: UIImage?)
    func display(releaseDate: String)
    func display(overview: String)
}

protocol DetailMoviePresenter {
    func viewDidLoad()
}

class DetailMoviePresenterImpl: DetailMoviePresenter {
    fileprivate weak var view: DetailMovieView?
    var movie: Movie!
    
    init(view: DetailMovieView,
         movie: Movie) {
        self.view = view
        self.movie = movie
    }
    
    func viewDidLoad() {
        self.view?.display(name: movie.name)
        self.view?.display(genres: movie.genres.map { "\($0.name)" }.joined(separator: "/"))
        self.view?.display(poster: UIImage.imageFromURL(string: movie.poster))
        self.view?.display(overview: movie.overview)
        self.view?.display(releaseDate: Date.string(from: movie.releaseDate))
    }
}
