import Foundation

protocol DetailMovieConfigurator {
    func configure(detailMovieViewController: DetailMovieViewController)
}

class DetailMovieConfiguratorImpl: DetailMovieConfigurator {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func configure(detailMovieViewController: DetailMovieViewController) {
        let presenter = DetailMoviePresenterImpl(view: detailMovieViewController,
                                                 movie: movie)
        detailMovieViewController.presenter = presenter
    }
    
}
