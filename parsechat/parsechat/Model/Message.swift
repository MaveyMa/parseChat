//
//  Message.swift
//  
//
//  Created by Mavey Ma on 2/26/18.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
  @NSManaged var author: PFUser
  @NSManaged var msg: String
  
  /* Needed to implement PFSubclassing interface */
  class func parseClassName() -> String {
    return "Message"
  }
  
  /**
   Method to add a user text to Parse
   - parameter caption: Message text input by the user
   - parameter completion: Block to be executed after save operation is complete
   */
  class func sendText(withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
    // use subclass approach
    let message = Message()
    
    // Add relevant fields to the object
    message.author = PFUser.current()! // Pointer column type that points to PFUser
    message.msg = caption!
    
    // Save object (following function will save the object in Parse asynchronously)
    message.saveInBackground(block: completion)
  }
}
