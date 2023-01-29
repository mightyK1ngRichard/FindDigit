//
//  TestViewController.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 29.01.2023.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func goToBlueController(_ sender: Any) {
        performSegue(withIdentifier: "goToBlue", sender: nil)
    }
    
}
