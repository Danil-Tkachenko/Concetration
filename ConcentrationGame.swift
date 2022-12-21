//
//  ConcentrationGame.swift
//  Concetration
//
//  Created by Леонид Шелудько on 27.10.2022.
//

import Foundation


struct ConcentrationGame {
    
    private(set) var cards = [Card]()  // [Card]() - структура, создаёт id для карточек
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {  // Индекс ОДНОЙ перевёрнутой карточки
        
        get{ // Проверяем все карты и смотрим есть ли одна карточка, если нашли - возвращаем индекс, если нет то nil
            
            return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly    // Проходимся по всем индексам. Фильтруем перевёрнутые. Если >1 то nil
            
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil { // если карточка была nil, то берём индекс этой карты
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {     // Проверяем есть ли одна перевёрнутая карточка и не нажимаем ещё раз
                if cards[matchingIndex] == cards[index]{               // Проверяем совпали ли у нас карточки
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index  // Добаввляем иидекс чтоб потом сравнить  по индексу
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) { // numberOfPairsOfCards - колличество кнопок ( которое разделено на 2)
        // asseert - утверждение, возврщает из приложения в то место, где мы указали утверждение
        assert(numberOfPairsOfCards > 0, "\(numberOfPairsOfCards) - должна быть хотя бы одна пара карт")
        // Нужно создать 2 парные карточки
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]  // Добавили 2 одинаковые карточки, с одинаковым ID
            cards = cards.shuffled() // Перемешать значения в массиве
        }
    }
    
}


extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
