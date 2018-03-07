import Foundation

class ApiGenreGatewayImpl: GenreGateway {
    var apiClient: ApiClient
    
    init(with apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchGenres(completion: @escaping FetchGenresCompletionHandler) {
        let genresRequest = GenresRequest()
        self.apiClient.execute(request: genresRequest) { (result: Result<ApiResponse<ApiGenreResponse>>) in
            switch result {
            case let .fail(error):
                completion(.fail(error))
            case let .success(response):
                let genres: [Genre] = response.entity.genres.map { $0.genre }
                completion(.success(genres))
            }
        }
    }
}
