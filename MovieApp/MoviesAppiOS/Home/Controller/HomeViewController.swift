//
//  ViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - PROPERTY
//    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var popularMovieTableView: UITableView!
    
    private let viewModel = HomeViewModel()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCallback()
        requestPopularMovie()
    }
    
    

    //MARK: - METHODS
    private func setupView() {
        // search button
        view.backgroundColor = UIColor.App.background
        title = "MovieBox"
        popularMovieTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        //Search Button
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        searchButton.setImage(UIImage(named: "ic_search"), for: .normal)
        searchButton.tintColor = UIColor.black
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        let searchBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func setupCallback() {
        viewModel.onLoadingChange = { isLoading in
            if isLoading {
                
            } else {
                
            }
        }
        
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.popularMovieTableView.reloadData()
                }
                break
            case .failure(let error):
                //show alert for error
                print(error)
                break
            }
        }
    }
    
    private func requestPopularMovie() {
        viewModel.requestPopularMovie()
    }
    
    @objc
    private func didTapSearchButton() {
        if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    private func navigateToDetailView(movie: MovieModel) {
        if let detailView = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailView.movie = movie
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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

