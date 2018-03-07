import UIKit

protocol SearchMovieConfigurator {
    func configure(searchMoviesViewController: SearchMoviesViewController)
    func configureSearchBarController(_ searchMoviesViewController: SearchMoviesViewController)
}

class SearchMovieConfiguratorImpl: SearchMovieConfigurator {
    
    func configure(searchMoviesViewController: SearchMoviesViewController) {
        let apiClient = ApiClientImpl(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        let apiMoviesGateway = ApiMovieGatewayImpl(apiClient: apiClient)
        let searchMoviesInteractor = SearchMovieInteractorImpl(with: apiMoviesGateway)
        let router = SearchMovieViewRouterImpl(searchMoviesViewController: searchMoviesViewController)
        let presenter = SearchMoviePresenterImpl(searchMovieInteractor: searchMoviesInteractor, view: searchMoviesViewController, router: router)
        
        searchMoviesViewController.presenter = presenter
    }
    
    func configureSearchBarController(_ searchMoviesViewController: SearchMoviesViewController) {
        searchMoviesViewController.searchController = UISearchController(searchResultsController: nil)
        searchMoviesViewController.searchController.searchResultsUpdater = searchMoviesViewController
        searchMoviesViewController.searchController.delegate = searchMoviesViewController
        searchMoviesViewController.searchController.searchBar.delegate = searchMoviesViewController
        searchMoviesViewController.searchController.searchBar.tintColor = UIColor.white
        
        searchMoviesViewController.searchController.hidesNavigationBarDuringPresentation = false
        searchMoviesViewController.searchController.dimsBackgroundDuringPresentation = true
        
        searchMoviesViewController.navigationItem.titleView = searchMoviesViewController.searchController.searchBar
        
        searchMoviesViewController.definesPresentationContext = true
    }
    
}
