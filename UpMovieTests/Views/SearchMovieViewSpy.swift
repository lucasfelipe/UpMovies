import Foundation
@testable import UpMovie

class SearchMovieViewSpy: SearchMovieView {
    var refreshSearchMoviesViewCalled = false
    var searchMovieErrorTitle = ""
    var searchMovieErrorMessage = ""
    
    func refreshSearchMoviesView() {
        refreshSearchMoviesViewCalled = true
    }
    
    func displaySearchMoviesError(title: String, message: String) {
        searchMovieErrorTitle = title
        searchMovieErrorMessage = message
    }
    
    
}
