//
//  ResultPageViewController.swift
//  Project
//
//  Created by Henrik Sandwall on 2018-11-08.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {

    @IBOutlet weak var playAgainBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainBtn.layer.cornerRadius = 20
        
        playAgainBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
    }
    

   

}
