import UIKit

protocol SearchMovieRouter: ViewRouter {
    func presentMovieDetail(movie: Movie)
}

class SearchMovieViewRouterImpl: SearchMovieRouter {
    fileprivate weak var searchMovieViewController: SearchMoviesViewController?
    fileprivate var movie: Movie!
    
    init(searchMoviesViewController: SearchMoviesViewController) {
        self.searchMovieViewController = searchMoviesViewController
    }
    
    func presentMovieDetail(movie: Movie) {
        self.movie = movie
        self.searchMovieViewController?.performSegue(withIdentifier: "SearchMovieDetailSegue", sender: self.searchMovieViewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? DetailMovieViewController {
            movieDetailViewController.configurator = DetailMovieConfiguratorImpl(movie: self.movie)
        }
    }
    
}
