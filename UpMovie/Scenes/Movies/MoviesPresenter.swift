import UIKit

protocol MoviesView: class {
    func refreshMoviesView()
    func displayMoviesError(title: String, message: String)
}

protocol MoviesViewCell {
    func display(name: String)
    func display(genres: String)
    func display(poster: UIImage?)
    func display(releaseDate: String)
}

protocol MoviesPresenter {
    func viewDidLoad()
    var numberOfMovies: Int { get }
    func didSelect(row: Int)
    func configure(cell: MoviesViewCell, forRow row: Int)
    var router: MoviesViewRouter { get }
    func loadMore(_ scrollView: UIScrollView)
    
}

class MoviesPresenterImpl: MoviesPresenter {
    //MARK: Properties
    fileprivate let displayMoviesInteractor: DisplayMoviesInteractor
    fileprivate let moviesViewRouter: MoviesViewRouter
    fileprivate weak var view: MoviesView?
    
    var movies = [Movie]()
    var numberOfMovies: Int {
        return movies.count
    }
    private var page = 1
    
    var router: MoviesViewRouter {
        return moviesViewRouter
    }
    
    //MARK: Init
    init(displayMoviesInteractor: DisplayMoviesInteractor,
         view: MoviesView,
         router: MoviesViewRouter) {
        self.displayMoviesInteractor = displayMoviesInteractor
        self.view = view
        self.moviesViewRouter = router
    }
    
    //MARK: View Events
    func viewDidLoad() {
        self.fetchMovies(in: page)
    }
    
    private func fetchMovies(in page: Int) {
        self.displayMoviesInteractor.displayMovies(in: page) { (result) in
            switch result {
            case let .success(movies):
                self.handleMoviesReceived(movies)
            case let .fail(error):
                self.handleMoviesError(error)
            }
        }
    }
    
    func loadMore(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y // Y position of the content showing in scroll view
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height // Max Y position of the scroll view
        if (maxOffset - offset) <= 60 {
            page += 1
            self.fetchMovies(in: page)
        }
    }
    
    func configure(cell: MoviesViewCell, forRow row: Int) {
        let movie = movies[row]
        
        cell.display(name: movie.name)
        cell.display(genres: movie.genres.map { "\($0.name)" }.joined(separator: "/"))
        cell.display(poster: UIImage.imageFromURL(string: movie.poster))
        cell.display(releaseDate: Date.string(from: movie.releaseDate))
    }
    
    func didSelect(row: Int) {
        self.moviesViewRouter.presentMovieDetail(movie: movies[row])
    }

    //MARK: Handlers
    fileprivate func handleMoviesReceived(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        self.view?.refreshMoviesView()
    }
    
    fileprivate func handleMoviesError(_ error: Error) {
        self.view?.displayMoviesError(title: "Error", message: error.localizedDescription)
    }
}
