import Foundation
@testable import UpMovie

class SearchMovieInteractorStub: SearchMovieInteractor {
    var listMoviesToBeReturned: Result<[Movie]>!
    
    func searchMovie(by name: String, completion: @escaping DisplaySearchMovieInteractorList) {
        completion(listMoviesToBeReturned)
    }
}
