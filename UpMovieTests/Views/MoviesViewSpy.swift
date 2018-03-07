import Foundation
@testable import UpMovie

class MoviesViewSpy: MoviesView {
    var refreshMoviesViewCalled = false
    var displayMoviesErrorTitle = ""
    var displayMoviesErrorMessage = ""
    
    func refreshMoviesView() {
        self.refreshMoviesViewCalled = true
    }
    
    func displayMoviesError(title: String, message: String) {
        self.displayMoviesErrorTitle = title
        self.displayMoviesErrorMessage = message
    }
}
