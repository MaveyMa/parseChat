//
//  ChatViewController.swift
//  parsechat
//
//  Created by Mavey Ma on 2/26/18.
//  Copyright © 2018 Mavey Ma. All rights reserved.
//
import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var chatTableView: UITableView!
  var messages: [Message] = []
  var refreshControl: UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    chatTableView.delegate = self
    chatTableView.dataSource = self
    
    chatTableView.rowHeight = UITableViewAutomaticDimension
    chatTableView.estimatedRowHeight = 100
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
    chatTableView.insertSubview(refreshControl, at: 0)
    
//    chatTableView.separatorStyle = .none
//    
//    bubbleView.layer.cornerRadius = 16
//    bubbleView.clipsToBounds = true
    
    //timer every 1 second
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
    let message = messages[indexPath.row]
    
    let msg = message.msg
    cell.chatTextLabel.text = msg
    
//    let person = message.author.username
//    cell.authorTextLabel.text = person
//
    if let user = message.author as? PFUser {
      // User found! update username label with username
      cell.authorTextLabel.text = user.username
    } else {
      // No user found, set default username
      cell.authorTextLabel.text = "🤖"
    }

    return cell
  }
  
  @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
    get20PostsFromParse()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSend(_ sender: Any) {
    print("Clicked send!")
    // Hides keyboard
    messageTextField.resignFirstResponder()
    Message.sendText(withCaption: messageTextField.text) { (success, error) in
      if success {
        print("The message was saved!")
        //print(self.messageTextField.text)
        self.messageTextField.text = ""
      } else if let error = error {
        print("Problem saving message: \(error.localizedDescription)")
      }
    }
  }
  
  func get20PostsFromParse(){
    let query = Message.query()
    query?.order(byDescending: "createdAt")
    query?.includeKey("author.username")
    query?.includeKey("createdAt")
    //query?.whereKey("author", equalTo: PFUser.current()!)
    query?.limit = 20
    
    // fetch data asynchronously
    query?.findObjectsInBackground { (Message, error: Error?) -> Void in
      if let messages = Message {
        // do something with the data fetched
        //print(messages)
        // passing over my local posts to my global posts
        self.messages = messages as! [Message]
      } else {
        // handle error
        print("Failed to retrieve 20 objects from Parse server")
      }
    }
    self.chatTableView.reloadData()
    //self.refreshControl.endRefreshing()
  }
  
  @IBAction func onLogout(_ sender: Any) {
    print("Clicked logout")
    NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
  }
  
  @objc func onTimer() {
    get20PostsFromParse()
  }
}
