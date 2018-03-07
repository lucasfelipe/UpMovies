import Foundation
@testable import UpMovie

class MoviesViewRouterSpy: MoviesViewRouter {
    var passedMovie: Movie? = nil

    func presentMovieDetail(movie: Movie) {
        self.passedMovie = movie
    }
    
}
