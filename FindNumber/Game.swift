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
        var isError: Bool = false
    }
    
    var items = [Item]()
    private var countItems: Int
    var nextItem: Item?
    var status: StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    private var timeForGame: Int
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
                
            }
            updateTimer(status, secondsGame)
        }
    }
    private var timer: Timer?
    private var updateTimer: ((StatusGame, Int) -> Void)
    
    
    init(countItems: Int, timerForGame time: Int, updateTimer: @escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.secondsGame = time
        self.updateTimer = updateTimer
        self.timeForGame = time
        setupGame()
    }
    
    
    private func setupGame() {
        var digits = Array(1...99).shuffled()
        items.removeAll()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        // Загадываем число для поиска.
        nextItem = items.shuffled().first
        updateTimer(status, secondsGame)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.secondsGame -= 1
        })
    }
    
    
    func check(index: Int) {
        guard status == .start else { return }
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {$0.isFound == false})
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    
    func newGame() {
        status = .start
        self.secondsGame = timeForGame
        setupGame()
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
    
}
