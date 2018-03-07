import UIKit

protocol SearchMovieView: class {
    func refreshSearchMoviesView()
    func displaySearchMoviesError(title: String, message: String)
}

protocol SearchMovieViewCell {
    func display(name: String)
    func display(genres: String)
    func display(poster: UIImage?)
}

protocol SearchMoviePresenter {
    func searchMovie(by name: String)
    var numberOfMovies: Int { get }
    func configure(cell: SearchMovieViewCell, forRow row: Int)
    func didSelect(row: Int)
    var router: SearchMovieRouter { get }
}

class SearchMoviePresenterImpl: SearchMoviePresenter {
    fileprivate weak var view: SearchMovieView?
    fileprivate let searchMovieInteractor: SearchMovieInteractor
    fileprivate let searchMovieRouter: SearchMovieRouter

    var movies = [Movie]()
    var numberOfMovies: Int {
        return movies.count
    }
    
    var router: SearchMovieRouter {
        return searchMovieRouter
    }
    
    init(searchMovieInteractor: SearchMovieInteractor,
         view: SearchMovieView,
         router: SearchMovieRouter) {
        self.searchMovieInteractor = searchMovieInteractor
        self.view = view
        self.searchMovieRouter = router
    }
    
    func searchMovie(by name: String) {
        self.searchMovieInteractor.searchMovie(by: name) { (result: Result<[Movie]>) in
            switch result {
            case let .success(movies):
                self.handleSearchMoviesReceived(movies)
            case let .fail(error):
                self.handleSearchMoviesError(error)
            }
        }
    }
    
    func configure(cell: SearchMovieViewCell, forRow row: Int) {
        let movie = movies[row]
        
        cell.display(name: movie.name)
        cell.display(genres: movie.genres.map { "\($0.name)" }.joined(separator: "/"))
        cell.display(poster: UIImage.imageFromURL(string: movie.poster))
    }
    
    func didSelect(row: Int) {
        let movie = movies[row]
        searchMovieRouter.presentMovieDetail(movie: movie)
    }
    
    private func handleSearchMoviesReceived(_ movies: [Movie]) {
        self.movies = movies
        self.view?.refreshSearchMoviesView()
    }
    
    private func handleSearchMoviesError(_ error: Error) {
        self.view?.displaySearchMoviesError(title: "Error", message: error.localizedDescription)
    }
}
