//
//  ViewController.swift
//  ColorSettingsApp
//
//  Created by Andrey Machulin on 10.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var numberOfRedLabel: UILabel!
    @IBOutlet var numberOfGreenLabel: UILabel!
    @IBOutlet var numberOfBlueLabel: UILabel!
    
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        colorView.layer.cornerRadius = 10
        setUpSlider()
        
    }
    
    // MARK: - IB Action
    
    @IBAction func redSliderAction() {
       
        
    }
    @IBAction func greenSliderAction() {
        numberOfGreenLabel.text = "\(greenSlider.value)"
    }
    
    @IBAction func blueSliderAction() {
        numberOfBlueLabel.text = "\(blueSlider.value)"
    }
    
    
    // MARK: - Privat Methods
    private func setUpSlider() {
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
}


