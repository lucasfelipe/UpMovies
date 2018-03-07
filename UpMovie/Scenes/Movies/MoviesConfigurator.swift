import Foundation

protocol MoviesConfigurator {
    func configure(moviesViewController: MoviesViewController)
}

class MoviesConfiguratorImpl: MoviesConfigurator {
    
    func configure(moviesViewController: MoviesViewController) {
        let apiClient = ApiClientImpl(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        let apiMoviesGateway = ApiMovieGatewayImpl(apiClient: apiClient)
        let displayMoviesInteractor = DisplayMoviesInteractorImpl(with: apiMoviesGateway)
        let router = MoviesViewRouterImpl(moviesViewController: moviesViewController)
        let presenter = MoviesPresenterImpl(displayMoviesInteractor: displayMoviesInteractor, view: moviesViewController, router: router)
        
        moviesViewController.presenter = presenter
    }
    
}
