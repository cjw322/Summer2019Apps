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
    
    var borderWidth: CGFloat!
    
    var calculatorLabel: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var timesButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet weak var oneStackView: UIStackView!
    @IBOutlet weak var fourStackView: UIStackView!
    @IBOutlet weak var sevenStackView: UIStackView!
    @IBOutlet weak var zeroStackView: UIStackView!
    @IBOutlet weak var clearStackView: UIStackView!
    
    var myButtons: [UIButton]!
    var circleButtons: [UIButton]!
    var squareButtons: [UIButton]!
    var myStackViews: [UIStackView]!
    var horizontalStackViews: [UIStackView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borderWidth = view.frame.width/20.0
        
        myButtons = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, equalsButton, clearButton, plusButton, minusButton, timesButton, divideButton]
        circleButtons = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton]
        squareButtons = [clearButton, plusButton, minusButton, timesButton, divideButton]
        myStackViews = [oneStackView, fourStackView, sevenStackView, zeroStackView, clearStackView]
        horizontalStackViews = [oneStackView, fourStackView, sevenStackView, zeroStackView]
        
        for button in myButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        calculatorLabel = UILabel()
        calculatorLabel.translatesAutoresizingMaskIntoConstraints = false
        calculatorLabel.text = "Calculator"
        calculatorLabel.font = UIFont.systemFont(ofSize: 50)
        calculatorLabel.textColor = .white
        view.addSubview(calculatorLabel)
        
            
        view.backgroundColor = .black
        setBackground()
        
        setConstraints()
        
    }
    
    func setConstraints() {
        
        setFontSize()
        
        // Determine values for oneStackView -------------------
        
        NSLayoutConstraint.activate([
            //oneStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            oneButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            //oneStackView.heightAnchor.constraint(equalTo: oneButton.widthAnchor),
            oneStackView.widthAnchor.constraint(equalTo: oneButton.widthAnchor, multiplier: 3, constant: (CGFloat(0.4*oneButton.bounds.width))),
            //oneStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        oneStackView.spacing = CGFloat(0.20*oneButton.bounds.width) // space is 1/5 of button width
        
        
        // Apply to all horizontal stackViews ---------------------
        
        for circleButton in circleButtons {
            NSLayoutConstraint.activate([
                circleButton.widthAnchor.constraint(equalTo: oneButton.widthAnchor),
                //circleButton.heightAnchor.constraint(equalToConstant: circleButton.frame.width)
                circleButton.heightAnchor.constraint(equalTo: oneButton.widthAnchor)
                // circleButton.heightAnchor.constraint(equalTo: circleButton.widthAnchor)
                ])
            
        }
        
        for horizontalStackView in horizontalStackViews {
            NSLayoutConstraint.activate([
                //horizontalStackView.heightAnchor.constraint(equalTo: oneStackView.heightAnchor),
                horizontalStackView.widthAnchor.constraint(equalTo: oneStackView.widthAnchor),
                //horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: borderWidth)
                ])
            
        }

        NSLayoutConstraint.activate([
            fourStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            oneStackView.centerYAnchor.constraint(equalTo: fourStackView.centerYAnchor, constant: (-twoButton.frame.height - 2*oneStackView.spacing)),
            sevenStackView.centerYAnchor.constraint(equalTo: fourStackView.centerYAnchor, constant: (twoButton.frame.height + 2*oneStackView.spacing)),
            zeroStackView.centerYAnchor.constraint(equalTo: sevenStackView.centerYAnchor, constant: (twoButton.frame.height + 2*oneStackView.spacing))

            ])
        
        for stackView in myStackViews {
            stackView.spacing = oneStackView.spacing
        }
        
        // Equals Button ---------------------------------
        
        NSLayoutConstraint.activate([
            equalsButton.heightAnchor.constraint(equalTo: zeroButton.heightAnchor),
            equalsButton.leadingAnchor.constraint(equalTo: eightButton.leadingAnchor),
            equalsButton.trailingAnchor.constraint(equalTo: nineButton.trailingAnchor)
            ])
        
        // Vertical stackView ----------------------------
        
        NSLayoutConstraint.activate([
            //clearStackView.topAnchor.constraint(equalTo: threeButton.topAnchor),
            clearButton.topAnchor.constraint(equalTo: threeButton.centerYAnchor),
            //clearStackView.bottomAnchor.constraint(equalTo: zeroButton.bottomAnchor),
            divideButton.bottomAnchor.constraint(equalTo: zeroButton.centerYAnchor)
            
            ])
        
        for button in squareButtons {
            NSLayoutConstraint.activate([
                button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -borderWidth),
                button.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.15),
                button.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.15)
                ])
            
        }
        
        // Calculator Label ------------------------------
        
        NSLayoutConstraint.activate([
            calculatorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: borderWidth),
            calculatorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: borderWidth)
        ])
        
    }
    
    func setFontSize() {
        print(view.frame.width)
        switch(view.frame.width) {
        case 0...500:
            oneButton.titleLabel?.font = oneButton.titleLabel?.font.withSize(60)
        case 500...800:
            oneButton.titleLabel?.font = oneButton.titleLabel?.font.withSize(100)
        case 800...2000:
            oneButton.titleLabel?.font = oneButton.titleLabel?.font.withSize(150)
        default:
            oneButton.titleLabel?.font = oneButton.titleLabel?.font.withSize(100)
        }
        
        let buttonFontSize = oneButton.titleLabel?.font
        for button in myButtons {
            button.titleLabel?.font = buttonFontSize
        }
        
        calculatorLabel.font = buttonFontSize
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

