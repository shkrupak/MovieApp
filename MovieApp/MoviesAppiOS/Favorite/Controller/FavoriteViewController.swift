//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK: - PROPERTY
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    private let viewModel = FavoriteViewModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteMovies()
    }
    
    //MARK: - METHOD
    private func setupView() {
        title = "Favorites"
        view.backgroundColor = UIColor.App.background
        favoriteMoviesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
    }
    
    private func setupCallback() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.favoriteMoviesTableView.reloadData()
                }
                break
            case .failure(let error):
                //show alert
                break
            }
        }
    }
    
    private func fetchFavoriteMovies() {
        viewModel.fetchFavoriteMovies()
    }
    
    private func navigateToDetailView(movie: MovieModel) {
        if let detailView = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailView.movie = movie
            detailView.loadOffline = true
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if let movie = viewModel.moviesResponse?.results[indexPath.row] as? MovieModel {
            cell.loadCellData(movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = viewModel.moviesResponse?.results[indexPath.row] as? MovieModel {
            navigateToDetailView(movie: movie)
        }
    }
}


