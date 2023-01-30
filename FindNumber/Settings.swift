//
//  Settings.swift
//  FindNumber
//
//  Created by Дмитрий Пермяков on 30.01.2023.
//

import Foundation

enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
}

struct SettingsGame: Codable {
    var timerState: Bool
    var timeForGame: Int
}


class Settings {
    static var shared = Settings()
    private let defaultSettigs = SettingsGame(timerState: true, timeForGame: 30)
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettigs) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defaultSettigs
            }
            
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    
    func resetSettings() {
        currentSettings = defaultSettigs
    }
}
