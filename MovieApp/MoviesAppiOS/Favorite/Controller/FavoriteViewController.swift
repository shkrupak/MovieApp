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
    
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - METHOD
    private func setupView() {
        title = "Favorites"
        view.backgroundColor = UIColor.App.background
        favoriteMoviesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
    }
    
    //MARK: - ACTION
    
    
    //MARK: - DELEGATE
    
    
}


