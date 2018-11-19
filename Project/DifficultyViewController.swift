//
//  DifficultyViewController.swift
//  Project
//
//  Created by Tompa on 2018-11-19.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar
        //navigationBarItems()
        
        // removes navbar bottom line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
