//
//  RegistrationVC.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 08.11.21.
//

import UIKit
import CoreData

class RegistrationVC: UIViewController {
    
    
    @IBOutlet private var name: UITextField!
    @IBOutlet private var surname: UITextField!
    @IBOutlet private var eMail: UITextField!
    @IBOutlet private var password: UITextField!
    @IBOutlet private var registrationButton: UIButton!
    @IBOutlet private var allInputs: [UITextField]!
    let userManager = UserManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationButton.layer.cornerRadius = Constants.cornerRadius
        allInputs.forEach({$0.layer.cornerRadius = Constants.cornerRadius})
    }
    
    
    @IBAction func goToLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "LoginVC", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func registrationPressed(_ sender: UIButton) {
        
        if allInputs.filter({$0.text?.isEmpty == true}) != [] {
            let alert = UIAlertController(title: "Some fields are blank", message: "In order to finish registration, please fill all given fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let newUser = UserModel(name: name.text!, surname: surname.text!, email: eMail.text!, password: password.text!)
            
            if userManager.isUserUnique(this: newUser){
                userManager.saveNewUser(this: newUser)
                let sb = UIStoryboard(name: "MainVC", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                vc.currentUser = newUser
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title: "E-mail is not unique", message: "Given email address has already been used, try with different one.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
}
