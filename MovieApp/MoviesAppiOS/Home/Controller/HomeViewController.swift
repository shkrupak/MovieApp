//
//  ViewController.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - PROPERTY
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    //MARK: - METHODS
    private func setupView() {
        // search button
        searchButton.setImage(UIImage(named: "ic_search"), for: .normal)
        searchButton.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        searchButton.tintColor = UIColor.black.withAlphaComponent(0.3)
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }

    //MARK: - ACTIONS
    @IBAction func didTapSearchButton(_ sender: Any) {
        if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    //MARK: - DELEGATES
}

