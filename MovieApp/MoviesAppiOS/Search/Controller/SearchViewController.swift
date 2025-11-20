//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - PROPERTY
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private let searchViewModel = SearchMovieViewModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - METHOD
    private func setupView() {
        title = "Search Movies"
        view.backgroundColor = UIColor.App.background
        searchTextField.becomeFirstResponder()
        searchTextField.addTarget(self, action: #selector(requestSearchMovie), for: .editingChanged)
        searchTextField.clearButtonMode = .whileEditing
        //search
        searchContainerView.layer.cornerRadius = searchContainerView.frame.height / 2

        searchResultTableView.backgroundColor = UIColor.App.background
        searchResultTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    @objc
    private func requestSearchMovie() {
        searchViewModel.requestSearchMovie(query: searchTextField.text ?? "") {  status, responseMessage in
            if status {
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
            }
            else {
                print(responseMessage)
            }
        }
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
