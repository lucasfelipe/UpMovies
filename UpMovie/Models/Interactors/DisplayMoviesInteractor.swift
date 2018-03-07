import Foundation

typealias DisplayMoviesInteractorList = (Result<[Movie]>) -> Void

protocol DisplayMoviesInteractor {
    func displayMovies(in page: Int, completion: @escaping DisplayMoviesInteractorList)
}

class DisplayMoviesInteractorImpl: DisplayMoviesInteractor {
    let movieGateway: MovieGateway
    
    init(with movieGateway: MovieGateway) {
        self.movieGateway = movieGateway
    }
    
    func displayMovies(in page: Int, completion: @escaping DisplayMoviesInteractorList) {
        self.movieGateway.fetchMovies(in: page) { (result) in
            completion(result)
        }
    }
    
}
