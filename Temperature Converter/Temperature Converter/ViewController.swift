//
//  ViewController.swift
//  Temperature Converter
//
//  Created by Cora Wu on 6/7/19.
//  Copyright © 2019 Cora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setGradientBackground()
        inputTextField.keyboardType = UIKeyboardType.numberPad
        self.addDoneButtonOnKeyboard()
        
        setUpConstraints()
        
    }
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        if let input = inputTextField.text {
            if (input == "") {
                return
            }
            
            if let temp = Double(input) {
                // if you can make a double from input, this block will execute
                
                var output = temp * (9 / 5) + 32
                output = round(output * 1000) / 1000
                outputLabel.text = String(output)
                
                counter += 1
                counterLabel.text = "Conversions: " + String(counter)
            }
        }
        
    }
    
    func setUpConstraints() {
        let height: Double = Double(view.bounds.height)
        
        NSLayoutConstraint.activate([
            convertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            convertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(height * 8/12))
            //convertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            outputLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outputLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(height * 3/12))
            ])
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(height * 5/12))
            ])
        
        NSLayoutConstraint.activate([
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(height * 6/12))
            ])
        
        NSLayoutConstraint.activate([
            counterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            counterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])
        
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        inputTextField.resignFirstResponder()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer() // draws color gradient over background
        gradientLayer.colors = [colorTop, colorBottom] // array of colors in gradient
        gradientLayer.locations = [0.0, 0.5] // defines location of each gradient stop
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}

