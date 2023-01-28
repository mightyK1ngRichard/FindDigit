//
//  GameViewController.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 28.01.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]! // Коллекция кнопок.
    lazy var game = Game(countItems: buttons.count)
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
    
    
    func setupScreen() {
    /* Функция создаёт кнопки с рандомными числами. */
        
        for i in game.items.indices {
            buttons[i].setTitle(game.items[i].title, for: .normal)
        }
        nextDigit.text = game.nextItem?.title
    }
    
    func updateUI() {
        /* Скрываем кнопку */
        for i in game.items.indices {
            buttons[i].isHidden = game.items[i].isFound
        }
        nextDigit.text = game.nextItem?.title
    }
}
