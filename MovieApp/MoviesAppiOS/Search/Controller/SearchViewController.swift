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
    
    private let searchViewModel = SearchMovieViewModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    //MARK: - METHOD
    private func setupView() {
        title = "Search Movies"
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
    
    private func setupBindings() {
        searchViewModel.onLoadingChange = { [weak self] isLoading in
            guard let self = self else { return }
            self.activityIndicator.isHidden = !isLoading
        }
        
        searchViewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
                break
            case .failure(let error):
                //show alert for error
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
        searchViewModel.requestSearchMovie(query: searchTextField.text ?? "")

    }
    
    private func navigateToDetailView(movie: MovieModel) {
        if let detailView = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailView.movie = movie
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
    
    
}
