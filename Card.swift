//
//  Card.swift
//  Concetration
//
//  Created by Леонид Шелудько on 27.10.2022.
//

import Foundation

struct Card : Hashable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false    //Перевёрнутость карточки
    var isMatched = false   // Совпадает с другой карточкой
    private var identifier: Int     // ID
    
    private static var identierNumber = 0
    
    private static func identifierGenerator() -> Int {
        identierNumber += 1
        return identierNumber
    }
    
    init() {
        self.identifier = Card.identifierGenerator()
    }
}


