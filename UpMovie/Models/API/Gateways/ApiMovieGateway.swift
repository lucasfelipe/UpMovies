import UIKit

class ApiMovieGatewayImpl: MovieGateway {
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchMovies(in page: Int, completion: @escaping FetchMoviesCompletionHandler) {
        let listMoviesRequest = ListMovieRequest(with: page)
        self.apiClient.execute(request: listMoviesRequest) { (result: Result<ApiResponse<ApiMovieResponse>>) in
            switch result {
            case let .fail(error):
                completion(.fail(error))
            case let .success(response):
                let movies: [Movie] = response.entity.movies.map { $0.movie }
                completion(.success(movies))
            }
        }
    }
    
    func searchMovies(by name: String, completion: @escaping FetchMoviesCompletionHandler) {
        let searchMovieRequest = SearchMovieRequest(with: name)
        self.apiClient.execute(request: searchMovieRequest) { (result: Result<ApiResponse<ApiMovieResponse>>) in
            switch result {
            case let .fail(error):
                completion(.fail(error))
            case let .success(response):
                let movies: [Movie] = response.entity.movies.map { $0.movie }
                completion(.success(movies))
            }
        }
    }
    
}
