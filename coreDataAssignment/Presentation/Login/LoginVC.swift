//
//  LoginVC.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 08.11.21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var allInputs: [UITextField]!
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allInputs.forEach({$0.layer.cornerRadius = Constants.cornerRadius})
        loginButton.layer.cornerRadius = Constants.cornerRadius
        
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if allInputs.filter({$0.text?.isEmpty == true}) != [] {
            
            let alert = UIAlertController(title: "Some fields are blank", message: "In order to finish registration, please fill all given fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            if let thisUser = userManager.fetchUserDataWith(this: email.text!){
                
                if thisUser.email == email.text && thisUser.password == password.text {
                    
                    let sb = UIStoryboard(name: "MainVC", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                    vc.currentUser = thisUser
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    print("VC presented")
                    
                } else {
                    
                    let alert = UIAlertController(title: "Wrong Password", message: "Provided password doesn't match given e-mail address.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            } else {
                let alert = UIAlertController(title: "No Such User", message: "User with current email address doesn't exist, please register first.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func goToRegistration(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RegistrationVC", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    


}
