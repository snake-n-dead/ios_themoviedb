//
//  PopularPopularPresenter.swift
//

import Foundation

class PopularPresenter {

    private weak var collectionMediator: PopularCollectionMediator?
    private weak var view: PopularViewInput?
    
    private let router: PopularRouterInput
    private var interactors = Interactors()

    private var movies: [Movie.Model] = [] { didSet { moviesChanged() } }
    private var genres: [Int: Genre.Model] = [:] { didSet { moviesChanged() } }
    
    private var searchResults: [Movie.Model] = []  { didSet { moviesChanged() } }
    private var searchText = "" { didSet { searchChanged() } }
    
    private var page: Int = 1
    private var data: [Movie.Model] {
        return searchText.isEmpty ? movies : searchResults
    }
    
    init(router: PopularRouterInput, view: PopularViewInput?, collectionMediator: PopularCollectionMediator?) {
        self.collectionMediator = collectionMediator
        self.router = router
        self.view = view
        
        setupDependencies()
    }

    private func setupDependencies() {
        collectionMediator?.fillCellData = {
            [weak self]
            (cellInput, indexPath) in
            guard let self_ = self else { return }
            let movie = self_.data[indexPath.row]
            cellInput.refresh(state: .posterURL(movie.posterPath))
            cellInput.refresh(state: .title(movie.title))
            cellInput.refresh(state: .rating(movie.voteAverage))
            cellInput.refresh(state: .ratingValue(Float(movie.voteAverage) / 10))

            let genres = movie.genreIds
                .compactMap({ $0 })
                .map({ self_.genres[$0]?.name ?? "" })
                .joined(separator: ", ")
            
            cellInput.refresh(state: .genres(genres))
        }

        collectionMediator?.cellSelectionClosure = {
            [weak self]
            (indexPath) in
            guard let self_ = self else { return }
            let movie = self_.data[indexPath.row]
            self_.router.showDetail(movie: movie)
        }
    }

    //MARK: - Private

    private func moviesChanged() {
        guard genres.count > 0 && movies.count > 0 else { return }
        collectionMediator?.dataCount = data.count
    }
    
    private func searchChanged() {
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }
        
        searchResults = movies.filter({
            $0.title.range(of: searchText, options: .caseInsensitive) != nil
        })
    }
}

//MARK: PopularViewOutput methods
extension PopularPresenter: PopularViewOutput {

    func viewOnReady() {
        loadPopular()
        loadGenres()
    }

    func viewOnAppear() {

    }
    
    func changed(searchText: String) {
        self.searchText = searchText
    }
}

private extension PopularPresenter {
    
    func loadPopular() {
        guard movies.count < Constants.popularMaximum else { return }
        interactors.movies.popular.request(page: page) {
            [weak self]
            result in
            
            switch result {
            case let .success(response):
                self?.movies.append(contentsOf: response.results.map(\.viewModel))
                self?.page += 1
                self?.loadPopular()
            case let.failure(error):
                self?.view?.show(info: .error(response: error))
            }
        }
    }
    
    func loadGenres() {
        interactors.genres.list.request {
            [weak self]
            result in
            
            switch result {
            case let .success(response):
                self?.genres = response.genres.reduce(into: [:], { $0[$1.id ?? 0] = $1.viewModel })
            case let .failure(error):
                self?.view?.show(info: .error(response: error))
            }
        }
    }
}
