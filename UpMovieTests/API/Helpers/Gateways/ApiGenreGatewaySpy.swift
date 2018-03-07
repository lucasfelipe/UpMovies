import Foundation
@testable import UpMovie

class ApiGenreGatewaySpy: GenreGateway {
    var fetchGenresResult: Result<[Genre]>!
    
    func fetchGenres(completion: @escaping FetchGenresCompletionHandler) {
        completion(fetchGenresResult)
    }
}
