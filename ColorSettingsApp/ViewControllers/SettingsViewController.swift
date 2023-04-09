//
//  ViewController.swift
//  ColorSettingsApp
//
//  Created by Andrey Machulin on 10.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    var delegate: SettingsViewControllersDelegte!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorView.backgroundColor = viewColor
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    //позволяет убирать клавиатуру при нажатии на экран, при этом завершается редактиврование текста
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Action
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    @IBAction func saveButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .black)
        dismiss(animated: true)
    }
    
    // MARK: - Privat Methods
    private func setColor() {
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textField: UITextField...) {
        textField.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: redSlider)
            default: blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func setUpAlertController (titel: String, message: String) {
        let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    //Вызов этой функции происходит, когда на экране скрывается клавиатура. По скрытию клавиатуры происходит завершении редактирования текстового поля. Логику того, что произойдет тогда, когда текст завершится, мы прописываем в коде сами.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Извлекаем опционал из текстового поля (проверяем, есть ли в нем текст, чтобы продолжить работу)
        guard let text = textField.text else { return }
        
        //Проверяем, можем ли мы из текстового поля привести данные к Float (так как Слайдеры работают с типом Float)
        if let currentValue = Float(text) {
            //если мы смогли сконвертировать данные в Float, то мы их перебераем
            switch textField {
                //если значение в redTextField, то мы передаем данные в красный Слайдер
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                //Также мы передаем данные из TextField в Label
                setValue(for: redLabel)
                //если значение в greenTextField, то мы передаем данные в зелёный Слайдер
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
                //Дефолтную ветку, как последний кейс
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            }
            //вызываем метод setColor, чтобы передать цвет в соотвествии с теми положениями Слайдеров, которые они принимают
            setColor()
            return
        }
        //если что-то пошло не так, вывает AlertController. Он появляется, если конструкция if выше не сработала
        setUpAlertController(titel: "Wrong format!", message: "Please, enter correct value.")
    }
    
    //Настройка ToolBar на клавиатуре
    
    //Данная функция срабатывает, когда мы начинаем редактировать TextField.
    //Во время начала работы с TextField, мы для него создаем ToolBar на клавиатуре. Именно для TextField, а не для клавиатуры. Просто он прикрепляется к ней. А по факту оно относится к текстовому полю.
    //Вместо того, чтобы реализовывать это в приватном методе и потом вызывать его 3 раза для каждого текстового поля, мы делаем это один раз в этом методе для всех текстовых полей.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //создаем экземпляр класса без указаний каких-либо размеров
        let keyboardToolbar = UIToolbar()
        //делаем Toolbar по ширине клавиатуры
        keyboardToolbar.sizeToFit()
        //присваиваем нашим текстовым полям этот Toolbar
        textField.inputAccessoryView = keyboardToolbar
         
        //Создаем кнопку Done на Toolbar
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            //target – это где будет вызван данный мотод при нажатии на Done. Мы метод "didTapDone" реализуем в самом Классе, поэтому указывем self, если бы он был реализован в другом Классе, нужно было бы его указать.
            target: self,
            action: #selector(didTapDone)
            )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
            
        //Добавляем элементы в Toolbar именно в таком порядке, чтобы кнопка Done была справа.
        keyboardToolbar.items = [flexBarButton, doneButton]
    }

}

