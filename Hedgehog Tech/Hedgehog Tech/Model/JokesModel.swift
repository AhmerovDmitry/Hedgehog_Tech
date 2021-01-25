//
//  JokesModel.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 24.01.2021.
//

struct JokesModels: Codable {
    var value: [Joke]
}

struct Joke: Codable {
    var joke: String
}
