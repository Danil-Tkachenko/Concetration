//
//  ViewController.swift
//  Concetration
//
//  Created by Леонид Шелудько on 26.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {                // кол-во  парных карт
        return (buttonCollection.count + 1) / 2
    }
    

    private func updateTOuches() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributesString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributesString
    }
    
    private(set) var touches = 0 {
        didSet{
            updateTOuches()
        }
    }
    
    
    
    
    
   //private var emojiCollection = ["🦊", "🐰", "🐹", "🦁", "🐙", "🐸", "🐶", "🐵", "🐷", "🪱", "🐣", "🐌"]
    
   private var emojiCollection = "🦊🐰🐹🦁🐙🐸🐶🐵🐷🪱🐣🐌"
    
   private var emojiDictionary = [Card: String]()
    
   private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStingIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStingIndex)) //убрать из (через расширенение вызвали                                                                                                              рандомное число)
        }
        return emojiDictionary[card] ?? "?"
    }
    
   private func updateViewFromModel () {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal) //setTitle - менять названние
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.154168427, green: 0.4783409834, blue: 1, alpha: 1)
            }
        }
    }
    
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTOuches()
        }
    }
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {   // firstIndex - перебрать по индексу
            game.chooseCard(at: buttonIndex) // передали индекс элемента
            
            updateViewFromModel()
        }
    }
    
    
    
    
}

//extension - расширения
extension Int {
    var arc4randomExtension : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))      //Возвращает рандомной число
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self)))) //abs - абсолюное число возврщает (отрицательное делает положительным числом)
        } else {
            return 0
        }
    }
}
