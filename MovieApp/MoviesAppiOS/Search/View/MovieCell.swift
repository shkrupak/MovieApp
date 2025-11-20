//
//  MovieCell.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteImage: UIImageView!
    @IBOutlet weak var movieContainerView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieOverView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieContainerView.layer.cornerRadius = 8
        movieContainerView.clipsToBounds = true
        movieImage.backgroundColor = UIColor.App.background.withAlphaComponent(0.6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData(movie: MovieModel) {
        movieTitleLabel.text = movie.title
        movieOverView.text = movie.overview
        movieImage.sd_setImage(with: URL(string: "\(APIConstant.getBaseUrl())\(movie.poster_path ?? "")"), placeholderImage: UIImage(named: "img_no_poster"))
        voteImage.image = UIImage(named: "ic_movie")
        voteCountLabel.text = "Vote: \(movie.vote_average?.rounded(toPlace: 1) ?? 0.0)/10"
    }

}
