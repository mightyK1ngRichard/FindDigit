//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 30.01.2023.
//

import UIKit

class SelectTimeViewController: UIViewController {
    var data = [Int]()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//         tableView.reloadData() // Это если обновлю число столбцов.
    }
}

extension SelectTimeViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row]) сек"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Когда выбираем число, подсвечивается ячейка.
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.setValue(indexPath.row, forKey: "timeForGame")
        UserDefaults.standard.integer(forKey: "timeForGame")
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
        
        // значение, которое выбрали.
//        print(data[indexPath.row])
        
    }
    
}
