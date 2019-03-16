//
//  ViewController.swift
//  Unihack2019
//
//  Created by Gabrielle Chandrasaputra on 16/3/19.
//  Copyright © 2019 Gabrielle Chandrasaputra. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginResponse(_ sender: Any) {
        print(email.text as Any)
        print(password.text as Any)
        
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (user, error) in
            if let error = error {
                print("error \(error)")
            }
            else {
                print("success")
                self.performSegue(withIdentifier: "logInSegue", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }


}

