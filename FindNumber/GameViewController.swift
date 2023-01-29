//
//  GameViewController.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 28.01.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttons: [UIButton]! // Коллекция кнопок.
    @IBOutlet weak var timerLabel: UILabel!
    lazy var game = Game(countItems: buttons.count, timerForGame: 30) { [weak self] (status, time) in
        guard let self = self else { return }
        self.timerLabel.text = time.textForTimer()
        self.updateInfoGame(with: status)
    }
    @IBOutlet weak var nextDigit: UILabel! // Загадывание числа для поиска.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Вызываем функцию создания кнопок.
        setupScreen()
    }
    
    
    // Нажатие на кнопку.
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        
        // скрываем кнопку при нажатии.
        updateUI()

    }
    
    @IBAction func pressNewGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    func setupScreen() {
    /* Функция создаёт кнопки с рандомными числами. */
        
        for i in game.items.indices {
            buttons[i].setTitle(game.items[i].title, for: .normal)
            buttons[i].isHidden = false
        }
        nextDigit.text = game.nextItem?.title
    }
    
    
    private func updateUI() {
        /* Скрываем кнопку */
        for i in game.items.indices {
            buttons[i].isHidden = game.items[i].isFound
            if game.items[i].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[i].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[i].backgroundColor = .white
                    self?.game.items[i].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы победили"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}

extension Int {
    func textForTimer() -> String {
        let minutes = self / 60
        let seconds = self % 60
        if minutes < 10 {
            return String(format: "0%d:%02d", minutes, seconds)
        }
        return String(format: "%d:%02d", minutes, seconds)
    }
}
