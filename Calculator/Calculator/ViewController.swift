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
    
    var calcState: CalcState = CalcState.enteringNum
    var currentOperator: Operator = Operator.NONE
    var firstValue: String = " "
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var calculatorLabel: UILabel!
    @IBOutlet weak var equalsButton: UIButton!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var oneStackView: UIStackView!
    @IBOutlet weak var fourStackView: UIStackView!
    @IBOutlet weak var sevenStackView: UIStackView!
    @IBOutlet weak var zeroStackView: UIStackView!
    @IBOutlet weak var numPadStackView: UIStackView!
    @IBOutlet weak var opStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setBackground()
        
        //view.backgroundColor = .white
        
        displayLabel.text = "0"
        
        setMainSVSizes()
        setNumButtonSizes()
        setOpButtonSizes()
    }
    
    func setMainSVSizes() {
        // leave 1/10 space on both sides
        
        var spacing: CGFloat
        
        if (self.view.frame.width/self.view.frame.height <= 7/10) {
            spacing = (1/20) * self.view.frame.height
        } else {
            spacing = (1/40) * self.view.frame.height
        }
        
//        let width = (4/5) * self.view.frame.width
//        let height = (3/5) * self.view.frame.height
//        let offset = -(1/10) * self.view.frame.height
        
        mainStackView.spacing = spacing
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            displayLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            //mainStackView.widthAnchor.constraint(equalToConstant: width),
            //mainStackView.heightAnchor.constraint(equalToConstant: height)
            ])
        
//        print(self.view.frame.width)
//        print(self.view.frame.height)
        
        switch self.view.frame.width {
        case 0...400:
            calculatorLabel.font = calculatorLabel.font.withSize(40)
            break
        case 400...600:
            calculatorLabel.font = calculatorLabel.font.withSize(50)
            break
        case 600...1000:
            calculatorLabel.font = calculatorLabel.font.withSize(100)
            break
        case 1000...2000:
            calculatorLabel.font = calculatorLabel.font.withSize(150)
            break
        default:
            break
        }
        
        displayLabel.font = calculatorLabel.font
    }
    
    func setNumButtonSizes() {
        // height is 1/5 of view's width
        // spacing is 1/8 height --> 1/40 width
        
        var height: CGFloat
        
        if (self.view.frame.width/self.view.frame.height <= 7/10) {
            height = (1/5) * self.view.frame.width
        } else {
            height = (1/6) * self.view.frame.width
        }
        let spacing = (1/8) * height
        let width = height*3 + spacing*2
        
        numPadStackView.spacing = spacing
        
        let numStackViews = [oneStackView, fourStackView, sevenStackView, zeroStackView]
        
        for possibleStackView in numStackViews {
            if let stackView = possibleStackView {
                stackView.spacing = spacing
            
                NSLayoutConstraint.activate([
                    equalsButton.widthAnchor.constraint(equalToConstant: (2*height + spacing)),
                    stackView.heightAnchor.constraint(equalToConstant: height),
                    stackView.widthAnchor.constraint(equalToConstant: width)
                    ])
            }
        }
        
    }
    
    func setOpButtonSizes() {
        var numHeight: CGFloat
        
        if (self.view.frame.width/self.view.frame.height <= 7/10) {
            numHeight = (1/5) * self.view.frame.width
        } else {
            numHeight = (1/6) * self.view.frame.width
        }
        
        let npSpacing = (1/8) * numHeight
        let npHeight = 4 * numHeight + 3 * npSpacing
        
        let opWidth = (1/5) * (npHeight - 3*npSpacing)
        
        NSLayoutConstraint.activate([
            opStackView.widthAnchor.constraint(equalToConstant: opWidth)
            ])
        
    }
    
    @IBAction func numberClicked (_ sender: UIButton) {
        
        updateDisplay(number: String(sender.tag))
        
    }
    
    func updateDisplay (number: String) {
        if calcState == CalcState.newNumStarted {
            if let num = displayLabel.text {
                if num != "" && num != "0" && num != " " {
                    firstValue = num
                }
            }
            
            calcState = CalcState.enteringNum
            displayLabel.text = number
            
        } else if calcState == CalcState.enteringNum {
            if let num = displayLabel.text {
                if num == "0" || num == " " {
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
            if num != "0" && num != "" && num != " " {
                firstValue = num
                displayLabel.text = " "
            }
        }
        
        switch sender.tag {
        case 10:
            currentOperator = Operator.PLUS
            //print("plus")
        break;
        case 11:
            currentOperator = Operator.MINUS
            //print("minus")
        break;
        case 12:
            currentOperator = Operator.TIMES
            //print("times")
        break;
        case 13:
            currentOperator = Operator.DIVIDE
            //print("divide")
        break;
        default:
            return
        }
    }
    
    @IBAction func clearClicked(_ sender: UIButton) {
        displayLabel.text = " "
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
        
        //print(firstValue)
        //print(Double(firstValue))
        //print( "display label \(Double(displayLabel.text!))")
        //print(Double(firstValue)! + Double(displayLabel.text!)!)
        
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
        
        displayLabel.text = "\(round(1000*Double(result)!)/1000)"
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

