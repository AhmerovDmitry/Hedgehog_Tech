//
//  NetworkService.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 24.01.2021.
//

import UIKit

class NetworkService {
    let baseUrl = "http://api.icndb.com/jokes/random/"
    
    func fetchJokes(processedText: String?, complition: @escaping (Result<[Joke], Error>) -> Void) {
        guard let processedText = processedText else { return }
        guard let url = URL(string: "\(baseUrl)\(processedText)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let joke = try JSONDecoder().decode(JokesModels.self, from: data)
                    complition(.success(joke.value))
                } catch let error {
                    complition(.failure(error))
                }
            }
        }.resume()
    }
    
}
