import Foundation

typealias FetchMoviesCompletionHandler = (_ movies: Result<[Movie]>) -> Void

protocol MovieGateway {
    func fetchMovies(in page: Int, completion: @escaping FetchMoviesCompletionHandler)
    func searchMovies(by name: String, completion: @escaping FetchMoviesCompletionHandler)
}
