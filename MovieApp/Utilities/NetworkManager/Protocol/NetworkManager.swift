//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

protocol NetworkManager {
    func loadData(request: URLRequest, completion: @escaping (Result<Data, RemoteAPIError>) -> Void)
}
