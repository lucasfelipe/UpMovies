import Foundation
@testable import UpMovie

class SearchMovieViewRouterSpy: SearchMovieRouter {
    var passedMovie: Movie? = nil
    
    func presentMovieDetail(movie: Movie) {
        self.passedMovie = movie
    }
}
