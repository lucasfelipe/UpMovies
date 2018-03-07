import XCTest
@testable import UpMovie

class MoviesPresenterTests: XCTestCase {

    let displayMoviesInteractorStub = DisplayMoviesInteractorStub()
    let moviesViewSpy = MoviesViewSpy()
    let moviesViewRouterSpy = MoviesViewRouterSpy()
    
    var moviesPresenter: MoviesPresenterImpl!
    
    override func setUp() {
        super.setUp()
        self.moviesPresenter = MoviesPresenterImpl(
            displayMoviesInteractor: displayMoviesInteractorStub,
            view: moviesViewSpy,
            router: moviesViewRouterSpy
        )
    }
    
    func testViewDidLoadShouldPresentMovies() {
        let moviesToBeReturned = Movie.createAnArray()
        displayMoviesInteractorStub.listMoviesToBeReturned = Result.success(moviesToBeReturned)
        
        self.moviesPresenter.viewDidLoad()
        
        XCTAssertTrue(moviesViewSpy.refreshMoviesViewCalled, "Refresh movies was not called")
    }
    
    func testViewDidLoadNumberOfMovies() {
        let numberOfMoviesExpected = 5
        let moviesToBeReturned = Movie.createAnArray(numberOfElements: numberOfMoviesExpected)
        
        displayMoviesInteractorStub.listMoviesToBeReturned = .success(moviesToBeReturned)
        
        moviesPresenter.viewDidLoad()
        
        XCTAssertEqual(numberOfMoviesExpected, moviesPresenter.numberOfMovies, "Number of movies dismatch")
    }
    
    func testViewDidLoadDisplayMoviesWithError() {
        let expectedErrorTitle = "Error"
        let expectedErrorMessage = "Error Message"
        let expectedError = NSError.createError(withMessage: expectedErrorMessage)
        
        displayMoviesInteractorStub.listMoviesToBeReturned = .fail(expectedError)
        
        moviesPresenter.viewDidLoad()
        
        XCTAssertEqual(expectedErrorTitle, moviesViewSpy.displayMoviesErrorTitle, "Error title not equal")
        XCTAssertEqual(expectedErrorMessage, moviesViewSpy.displayMoviesErrorMessage, "Error message not equal")
        
    }
    
    func testDisplayMovieViewCell() {
        moviesPresenter.movies = Movie.createAnArray()
        let firstMovie = moviesPresenter.movies[0]
        let expectedDisplayName = firstMovie.name
        let expectedDisplayGenres = firstMovie.genres.map { "\($0.name)" }.joined(separator: ", ")
        let expectedDisplayPoster = UIImage.imageFromURL(string: firstMovie.poster)
        let expectedDisplayReleaseDate = Date.string(from: firstMovie.releaseDate)
        
        let moviesViewCellSpy = MoviesViewCellSpy()
        
        moviesPresenter.configure(cell: moviesViewCellSpy, forRow: 0)
        
        XCTAssertEqual(expectedDisplayName, moviesViewCellSpy.name)
        XCTAssertEqual(expectedDisplayGenres, moviesViewCellSpy.genres)
        XCTAssertEqual(UIImageJPEGRepresentation(expectedDisplayPoster!, 0.0), UIImageJPEGRepresentation(moviesViewCellSpy.poster!, 0.0))
        XCTAssertEqual(expectedDisplayReleaseDate, moviesViewCellSpy.releaseDate)
    
    }
    
    func testDidSelectMovieCallDetailView() {
        let movies = Movie.createAnArray()
        let rowToDetail = 1
        moviesPresenter.movies = movies
        
        moviesPresenter.didSelect(row: rowToDetail)
        
        XCTAssertEqual(movies[rowToDetail], moviesViewRouterSpy.passedMovie, "The movie passed need to be the movie selected")
        
    }
    
    
}
