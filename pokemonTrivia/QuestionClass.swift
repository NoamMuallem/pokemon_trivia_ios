//
//  Question class.swift
//  pokemonTrivia
//
//  Created by noam muallem on 27/05/2022.
//

import Foundation

struct Question: Codable{
    var imageUrl:String;
    var answer1:String;
    var answer2:String;
    var answer3:String;
    var answer4:String;
    var rightAnswer:Int;
}

struct Questions: Codable{
    let questions:[Question]
}
