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
    var threeButton: UIButton!
    var circleImage: UIImage!
    
    @IBOutlet weak var oneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        setBackground()
        
        
        
        
        
//        circleImage = UIImage(named: "circle")
//
//        threeButton = UIButton()
//        threeButton.setBackgroundImage(circleImage, for: .normal)
//        threeButton.setTitle("3", for: .normal)
//        threeButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(threeButton)
//
//        NSLayoutConstraint.activate([
//            threeButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
//            threeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            threeButton.widthAnchor.constraint(equalToConstant: 100),
//            threeButton.heightAnchor.constraint(equalToConstant: 100)
//            ])
        
        
    }

    func setBackground() {
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(CIImage(image: UIImage(named: "ocean")!), forKey: kCIInputImageKey)
        blurFilter.setValue(10, forKey: kCIInputRadiusKey)
        
        backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = false
        backgroundImage.contentMode = .scaleAspectFill
        //backgroundImage.image = UIImage(named: "ocean")
        backgroundImage.image = UIImage(ciImage: blurFilter.outputImage!)
        backgroundImage.isOpaque = false
        backgroundImage.alpha = 0.6
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        
        
    }
}

