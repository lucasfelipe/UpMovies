import XCTest
@testable import UpMovie

class SearchMoviePresenterTests: XCTestCase {
    let searchMovieInteractorStub = SearchMovieInteractorStub()
    let searchMovieViewSpy = SearchMovieViewSpy()
    
    var searchMoviePresenter: SearchMoviePresenterImpl!
    
    override func setUp() {
        super.setUp()
        self.searchMoviePresenter = SearchMoviePresenterImpl(
            searchMovieInteractor: searchMovieInteractorStub,
            view: searchMovieViewSpy
        )
    }
    
    func testSearchMovieShouldPresentMovies() {
        let numberOfMoviesExpected = 5
        let moviesToBeReturned = Movie.createAnArray(numberOfElements: numberOfMoviesExpected)
        searchMovieInteractorStub.listMoviesToBeReturned = .success(moviesToBeReturned)
        
        searchMoviePresenter.searchMovie(by: "string")
        
        XCTAssertEqual(numberOfMoviesExpected, searchMoviePresenter.numberOfMovies, "Number of movies dismatch")
        XCTAssertTrue(searchMovieViewSpy.refreshSearchMoviesViewCalled, "Refresh Search Movies must to be called")
    }
    
    func testSearchMovieShouldPresentError() {
        let expectedErrorTitle = "Error"
        let expectedErrorMessage = "Error Message"
        let expectedError = NSError.createError(withMessage: expectedErrorMessage)
        
        self.searchMovieInteractorStub.listMoviesToBeReturned = .fail(expectedError)
        
        self.searchMoviePresenter.searchMovie(by: "this string will fail")
        
        XCTAssertEqual(expectedErrorTitle, searchMovieViewSpy.searchMovieErrorTitle, "Error title not equal")
        XCTAssertEqual(expectedErrorMessage, searchMovieViewSpy.searchMovieErrorMessage, "Error message not equal")
    }
    
    func testDisplayMovieViewCell() {
        searchMoviePresenter.movies = Movie.createAnArray()
        let firstMovie = searchMoviePresenter.movies[0]
        let expectedDisplayName = firstMovie.name
        let expectedDisplayGenres = firstMovie.genres.map { "\($0)" }.joined(separator: ", ")
        let expectedDisplayPoster = UIImage.imageFromURL(string: firstMovie.poster)
        
        let searchMoviesViewCellSpy = SearchMovieViewCellSpy()
        
        searchMoviePresenter.configure(cell: searchMoviesViewCellSpy, forRow: 0)
        
        XCTAssertEqual(expectedDisplayName, searchMoviesViewCellSpy.name)
        XCTAssertEqual(expectedDisplayGenres, searchMoviesViewCellSpy.genres)
        XCTAssertEqual(UIImageJPEGRepresentation(expectedDisplayPoster!, 0.0), UIImageJPEGRepresentation(searchMoviesViewCellSpy.poster!, 0.0))
        
    }
    
}
