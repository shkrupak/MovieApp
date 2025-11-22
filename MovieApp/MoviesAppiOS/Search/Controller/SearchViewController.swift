//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - OUTLET & PROPERTY
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    private let searchViewModel = SearchMovieViewModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCallback()
        searchViewModel.fetchRecentSearch()
    }
    
    //MARK: - METHOD
    private func setupView() {
        title = "Search Movies"
        searchTextField.placeholder = "Search Movies"
        resultTitleLabel.text = ""
        view.backgroundColor = UIColor.App.background
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        searchTextField.becomeFirstResponder()
        searchTextField.addTarget(self, action: #selector(requestSearchMovie), for: .editingChanged)
        searchTextField.clearButtonMode = .whileEditing
        
        //search
        searchContainerView.layer.cornerRadius = searchContainerView.frame.height / 2
        
        searchResultTableView.backgroundColor = UIColor.App.background
        searchResultTableView.keyboardDismissMode = .onDrag
    }
    
    private func setupCallback() {
        searchViewModel.onLoadingChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = !isLoading
            }
        }
        
        searchViewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.resultTitleLabel.text = self.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Recently Searched and Viewed" : "Search Result"
                    self.searchResultTableView.reloadData()
                }
                break
            case .failure(let errorMessage):
                DispatchQueue.main.async {
                    self.showAlertWith(message: errorMessage)
                    if (self.searchViewModel.moviesResponse?.results ?? []).isEmpty {
                        self.resultTitleLabel.text = "No movies found"
                    }
                    self.searchResultTableView.reloadData()
                }
                break
                
            case .cleared:
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
                break
            }
        }
    }
    
    @objc
    private func requestSearchMovie() {
        searchViewModel.resetPagination()
        searchViewModel.requestSearchMovie(query: searchTextField.text ?? "")
        if searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            searchViewModel.fetchRecentSearch()
        }
    }
    
    private func navigateToDetailView(movie: MovieModel) {
        if let detailView = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailView.movie = movie
            detailView.callingView = .search
            detailView.loadOffline = !Network.isNetworkAvailable()
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.moviesResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if let movie = searchViewModel.moviesResponse?.results[indexPath.row] as? MovieModel {
            cell.loadCellData(movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = searchViewModel.moviesResponse?.results[indexPath.row] as? MovieModel {
            navigateToDetailView(movie: movie)
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let movieResponse = searchViewModel.moviesResponse?.results {
            if indexPath.row == movieResponse.count - 3 && searchViewModel.shouldPaginate {
                searchViewModel.requestSearchMovie(query: self.searchTextField.text ?? "")
            }
        }
       
    }
}
