import Foundation

typealias FetchGenresCompletionHandler = (_ genres: Result<[Genre]>) -> Void

protocol GenreGateway {
    func fetchGenres(completion: @escaping FetchGenresCompletionHandler)
}
