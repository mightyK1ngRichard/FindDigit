//
//  Game.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 28.01.2023.
//

import Foundation

enum StatusGame {
    case win
    case lose
    case start
}
class Game {
    struct Item {
        var title: String
        var isFound: Bool = false
    }
    
    var items = [Item]()
    private var countItems: Int
    var nextItem: Item?
    var status: StatusGame = .start
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
    
    private func setupGame() {
        var digits = Array(1...99).shuffled()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        // Загадываем число для поиска.
        nextItem = items.shuffled().first
    }
    
    func check(index: Int) {
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {$0.isFound == false})
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
}
