import Foundation

typealias DisplaySearchMovieInteractorList = (Result<[Movie]>) -> Void

protocol SearchMovieInteractor {
    func searchMovie(by name: String, completion: @escaping DisplaySearchMovieInteractorList)
}

class SearchMovieInteractorImpl: SearchMovieInteractor {
    let movieGateway: MovieGateway
    
    init(with movieGateway: MovieGateway) {
        self.movieGateway = movieGateway
    }
    
    func searchMovie(by name: String, completion: @escaping DisplaySearchMovieInteractorList) {
        self.movieGateway.searchMovies(by: name) { (result: Result<[Movie]>) in
            completion(result)
        }
    }
}
