import UIKit

protocol MoviesViewRouter: ViewRouter {
    func presentMovieDetail(movie: Movie)
}

class MoviesViewRouterImpl: MoviesViewRouter {
    fileprivate weak var moviesViewController: MoviesViewController?
    fileprivate var movie: Movie!
    
    init(moviesViewController: MoviesViewController) {
        self.moviesViewController = moviesViewController
    }
    
    //MARK: MovieViewRouter
    func presentMovieDetail(movie: Movie) {
        self.movie = movie
        self.moviesViewController?.performSegue(withIdentifier: "MovieDetailSegue", sender: self.moviesViewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? DetailMovieViewController {
            movieDetailViewController.configurator = DetailMovieConfiguratorImpl(movie: self.movie)
        }
    }
    
}
