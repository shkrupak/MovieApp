//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    //MARK: - PROPERTY
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releasedDateContainerView: UIView!
    
    @IBOutlet weak var runtimeContainerView: UIView!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: MovieModel?
    private let viewModel = MovieDetailViewModel()
    private var favoriteButton: UIButton?
    
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestMovieDetail()
    }
    
    //MARK: - METHOD
    private func setupView() {
        movieImage.contentMode = .scaleAspectFill
        movieImage.image = UIImage(named: "img_no_poster")
        movieImage.layer.cornerRadius = 26
        
        detailContainerView.backgroundColor = UIColor.App.background
        releasedDateContainerView.layer.cornerRadius = 8
        runtimeContainerView.layer.cornerRadius = 8
        
        //bookmark/favorite button
        favoriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if let favoriteButton = favoriteButton {
            favoriteButton.setImage(UIImage(named: "ic_heart"), for: .normal)
            favoriteButton.tintColor = .black
            favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
            let rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
 
    
    @objc
    private func toggleFavorite() {
        let isFav = viewModel.toggleFavorite(movieID: movie?.id ?? 0)
        favoriteButton?.tintColor = isFav ? UIColor.App.favorite : UIColor.black
    }
    
    private func updateView() {
        favoriteButton?.tintColor = viewModel.isMovieFavorite(movieID: movie?.id ?? 0) ? UIColor.App.favorite : UIColor.black
        
        if let movieResponse = viewModel.movieDetailResponse {
            movieImage.setImage(named: movieResponse.backdrop_path ?? "") { [weak self] status in
                if !status {
                    self?.movieImage.image = UIImage(named: "img_no_poster")
                }
            }
            movieTitleLabel.text = movieResponse.title
            releasedDateLabel.text = movieResponse.release_date?.formatDateTo(inputFormat: .yMMdd, outputFormat: .ddMMMy) ?? ""
            runtimeLabel.text = "\(movieResponse.runtime ?? 0) mins"
            overviewLabel.text = movieResponse.overview
        }
        
    }
    
    private func requestMovieDetail() {
        guard let movie = movie else {
            return
        }
        viewModel.requestMovieDetail(movieID: movie.id ?? 0) { status, responseMessage in
            print(responseMessage)
            if status {
                DispatchQueue.main.async {
                    self.updateView()
                }
            }
            else {
                //show alert - details can't be fetched and dismiss by tapping ok
            }
        }
    }
    
    //MARK: - ACTION
    
    
    //MARK: - DELEGATE
    
    
}
