//
//  ViewController.swift
//  PhnTechTask
//
//  Created by STC on 22/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.text = " "
       
    }
    func ValidationCode() {
       
       if  let email = EmailTextField.text,let password = passwordTextField.text{
           if !email.validateEmailId(){
               let emailNil = UIAlertController(title: "Alert", message: "Email Incorrect", preferredStyle: UIAlertController.Style.alert)
               emailNil.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
               self.present(emailNil, animated: true,completion: nil)

           }else if !password.validatePassword(){
               let WrongPassword = UIAlertController(title: "Alert", message: "plese enter valid password", preferredStyle: UIAlertController.Style.alert)
               WrongPassword.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
               self.present(WrongPassword, animated: true,completion: nil)
           }
           else{
               //
           }
       }else{
           let emptyDetails = UIAlertController(title: "Alert", message: "Empty MAil and password", preferredStyle: UIAlertController.Style.alert)
           emptyDetails.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
           self.present(emptyDetails, animated: true,completion: nil)
       }

}


    @IBAction func LoginButton(_ sender: Any) {
        ValidationCode()
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController")as! secondViewController
        
        let dataToPass = self.nameTextField.text
        nav.dataFromFVC = dataToPass
       
        navigationController?.present(nav, animated: true)
    }
    
}

    
