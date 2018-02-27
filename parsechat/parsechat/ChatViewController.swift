//
//  ChatViewController.swift
//  parsechat
//
//  Created by Mavey Ma on 2/26/18.
//  Copyright © 2018 Mavey Ma. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
  
  @IBOutlet weak var messageTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSend(_ sender: Any) {
    print("Clicked send!")
    let chatMessage = PFObject(className: "Message")
    chatMessage["text"] = messageTextField.text ?? ""
    chatMessage.saveInBackground { (success, error) in
      if success {
        print("The message was saved!")
        self.messageTextField.text = ""
      } else if let error = error {
        print("Problem saving message: \(error.localizedDescription)")
      }
    }
  }
  
}
