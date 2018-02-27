//
//  LoginViewController.swift
//  parsechat
//
//  Created by Mavey Ma on 2/26/18.
//  Copyright © 2018 Mavey Ma. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSignUp(_ sender: Any) {
    print("Clicked Sign up")
    
    if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
      self.popUpMessage(title: "Whoops!", message: "Username and password cannot be left empty.", confirmation: "OK")
    } else {
      let newUser = PFUser()
      newUser.username = usernameTextField.text
      newUser.password = passwordTextField.text
    
      newUser.signUpInBackground { (success, error) in
        if success {
          print("Yay, created a user!")
          self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else if let e = error as NSError? {
          print(e.localizedDescription)
          self.popUpMessage(title: "Failed to sign up.", message: e.localizedDescription, confirmation: "OK")
        }
      }
    }
    
  }
  
  @IBAction func onLogin(_ sender: Any) {
    print("Clicked Login")
    
    PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
      if user != nil {
        print("You're logged in!")
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
      } else if let e = error as NSError? {
        print(e.localizedDescription)
        self.popUpMessage(title: "Failed to log in.", message: e.localizedDescription, confirmation: "OK")
      }
    }
  }
  
  func popUpMessage(title: String, message: String, confirmation: String) {
    let alertControllerError = UIAlertController(title: title, message: message, preferredStyle: .alert)
    // create a cancel action
    let cancelAction = UIAlertAction(title: confirmation, style: .cancel) { (action) in
      // handle cancel response here. Doing nothing will dismiss the view.
    }
    // add the cancel action to the alertController
    alertControllerError.addAction(cancelAction)
    present(alertControllerError, animated: true)
  }
  
}

