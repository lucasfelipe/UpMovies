import Foundation
@testable import UpMovie

class ApiMovieGatewaySpy: MovieGateway {
    var fetchMoviesResult: Result<[Movie]>!

    func fetchMovies(in page: Int, completion: @escaping FetchMoviesCompletionHandler) {
        completion(fetchMoviesResult)
    }
    
    func searchMovies(by name: String, completion: @escaping FetchMoviesCompletionHandler) {
        completion(fetchMoviesResult)
    }

}

