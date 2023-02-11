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
    @IBOutlet var redNuberLabel: UILabel!
    @IBOutlet var greenNumberLabel: UILabel!
    @IBOutlet var blueNumberLabel: UILabel!
    
    
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
        let sliderValue = String(format: "%.2f", redSlider.value)
        redNuberLabel.text = String(sliderValue)

        changeViewColor()
    }
    
    @IBAction func greenSliderAction() {
        let sliderValue = String(format: "%.2f", greenSlider.value)
        greenNumberLabel.text = String(sliderValue)
        
        changeViewColor()
    }
    
    @IBAction func blueSliderAction() {
        let sliderValue = String(format: "%.2f", blueSlider.value)
        blueNumberLabel.text = String(sliderValue)
        
        changeViewColor()
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
    
    private func changeViewColor() {
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1)
        )
    }
    
    
}


