//
//  ViewController.swift
//  Calculator
//
//  Created by Cora Wu on 6/11/19.
//  Copyright © 2019 Cora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundImage: UIImageView!
    
    @IBOutlet weak var displayLabel: UILabel!
    var calcState: CalcState = CalcState.enteringNum
    var currentOperator: Operator = Operator.NONE
    var firstValue: String = ""
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setBackground()
        
        //view.backgroundColor = .white
        
        displayLabel.text = "0"
        
        setMainSVSizes()
        setNumButtonSizes()
    }
    
    func setMainSVSizes() {
        // leave 1/10 space on both sides
        
        let width = (4/5) * self.view.frame.width
        let height = (4/5) * self.view.frame.height
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: width),
            mainStackView.heightAnchor.constraint(equalToConstant: height)
            ])
        
        print(self.view.frame.width)
        
//        switch self.view.frame.width {
//
//        }
    }
    
    func setNumButtonSizes() {
        
    }
    
    @IBAction func numberClicked (_ sender: UIButton) {
        
        updateDisplay(number: String(sender.tag))
        
    }
    
    func updateDisplay (number: String) {
        if calcState == CalcState.newNumStarted {
            if let num = displayLabel.text {
                if num != "" && num != "0" {
                    firstValue = num
                }
            }
            
            calcState = CalcState.enteringNum
            displayLabel.text = number
            
        } else if calcState == CalcState.enteringNum {
            if let num = displayLabel.text {
                if num == "0" {
                    displayLabel.text = number
                } else {
                    displayLabel.text = num + number
                }
            }
        }
    }
    
    @IBAction func operatorClicked (_ sender: UIButton) {
        calcState = CalcState.newNumStarted
        
        if let num = displayLabel.text {
            if num != "0" && num != "" {
                firstValue = num
                displayLabel.text = ""
            }
        }
        
        switch sender.tag {
        case 10:
            currentOperator = Operator.PLUS
            print("plus")
        break;
        case 11:
            currentOperator = Operator.MINUS
            print("minus")
        break;
        case 12:
            currentOperator = Operator.TIMES
            print("times")
        break;
        case 13:
            currentOperator = Operator.DIVIDE
            print("divide")
        break;
        default:
            return
        }
    }
    
    @IBAction func clearClicked(_ sender: UIButton) {
        displayLabel.text = ""
        if calcState == CalcState.newNumStarted {
            currentOperator = Operator.NONE
            firstValue = ""
            calcState = CalcState.enteringNum
        }
    }
    
    @IBAction func equalsClicked (_ sender: UIButton) {
        calculate()
    }
    
    func calculate() {
        if firstValue.isEmpty || firstValue == " " {
            return
        }
        
        print(firstValue)
        print(Double(firstValue))
        print( "display label \(Double(displayLabel.text!))")
        print(Double(firstValue)! + Double(displayLabel.text!)!)
        
        var result = ""
        switch currentOperator {
        case Operator.PLUS:
            result = "\(Double(firstValue)! + Double(displayLabel.text!)!)"
        case Operator.MINUS:
            result = "\(Double(firstValue)! - Double(displayLabel.text!)!)"
        case Operator.TIMES:
            result = "\(Double(firstValue)! * Double(displayLabel.text!)!)"
        case Operator.DIVIDE:
            result = "\(Double(firstValue)! / Double(displayLabel.text!)!)"
        default:
            return
        }
        
        displayLabel.text = result
        calcState = CalcState.newNumStarted
        firstValue = result
    }
    
    func setBackground() {
        
//        let blurFilter = CIFilter(name: "CIGaussianBlur")!
//        blurFilter.setValue(CIImage(image: UIImage(named: "ocean")!), forKey: kCIInputImageKey)
//        blurFilter.setValue(10, forKey: kCIInputRadiusKey)
        
        backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "ocean")
//        backgroundImage.image = UIImage(ciImage: blurFilter.outputImage!)
        backgroundImage.isOpaque = false
        backgroundImage.alpha = 0.6
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        
        
    }
}

