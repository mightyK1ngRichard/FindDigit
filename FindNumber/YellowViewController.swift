//
//  YellowViewController.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 29.01.2023.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func goToBlackController(_ sender: Any) {
        performSegue(withIdentifier: "goToBlack", sender: nil)
    }
}
