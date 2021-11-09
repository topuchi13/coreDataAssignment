//
//  GreetingScreen.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 08.11.21.
//

import UIKit

class GreetingScreen: UIViewController {
    
    
    @IBOutlet private var allButtons: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        allButtons.forEach({
            $0.layer.cornerRadius = Constants.cornerRadius
        })
   
    }
    

}
