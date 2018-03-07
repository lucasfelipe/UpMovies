import Foundation
@testable import UpMovie

class DisplayMoviesInteractorStub: DisplayMoviesInteractor {
    var listMoviesToBeReturned: Result<[Movie]>!
    
    func displayMovies(in page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        completion(listMoviesToBeReturned)
    }
}
