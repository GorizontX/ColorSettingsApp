//
//  MainViewController.swift
//  ColorSettingsApp
//
//  Created by Andrey Machulin on 04.04.2023.
//

import UIKit

protocol SettingsViewControllersDelegte {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.viewColor = view.backgroundColor
    }
}

// MARK: - ColorDelegate
extension MainViewController: SettingsViewControllersDelegte {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
