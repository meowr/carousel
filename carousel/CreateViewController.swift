//
//  CreateViewController.swift
//  carousel
//
//  Created by Tina Chen on 2/14/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var navBar: UIImageView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var termsAccepted = false
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    var defaults = NSUserDefaults.standardUserDefaults()
    var animate = true
    
    let firstNameEmptyAlertController = UIAlertController(title: "First name required", message: "Please enter your first name", preferredStyle: .Alert)
    let lastNameEmptyAlertController = UIAlertController(title: "Last name required", message: "Please enter your last name", preferredStyle: .Alert)
    let emailEmptyAlertController = UIAlertController(title: "Email required", message: "Please enter an email address", preferredStyle: .Alert)
    let passwordEmptyAlertController = UIAlertController(title: "Password required", message: "Please enter a password", preferredStyle: .Alert)
    let invalidAlertController = UIAlertController(title: "Invalid password", message: "Password must be at least 6 characters in length", preferredStyle: .Alert)
    
    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        // handle response here.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        scrollView.delegate = self
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -127
        
        defaults.setObject("true", forKey: "animate")
        defaults.synchronize()
            
        firstNameEmptyAlertController.addAction(OKAction)
        lastNameEmptyAlertController.addAction(OKAction)
        emailEmptyAlertController.addAction(OKAction)
        passwordEmptyAlertController.addAction(OKAction)
        invalidAlertController.addAction(OKAction)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if defaults.objectForKey("animate") as! String == "true" {
            let transform = CGAffineTransformMakeScale(0.2, 0.2)
            navBar.transform = transform
            fieldParentView.transform = transform
            navBar.alpha = 0
            fieldParentView.alpha = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.navBar.transform = CGAffineTransformIdentity
            self.fieldParentView.alpha = 1
            self.navBar.alpha = 1
        }
    }
    func keyboardWillShow(notification: NSNotification!) {
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        buttonParentView.frame.origin.y = buttonInitialY
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y <= -50 {
            // Hide the keyboard
            view.endEditing(true)
        }
    }
    
    @IBAction func onTermsButton(sender: UIButton) {
        termsAccepted = !termsAccepted
        sender.selected = termsAccepted
    }

    @IBAction func onBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onCreateButton(sender: UIButton) {
        if firstName.text!.isEmpty {
            presentViewController(firstNameEmptyAlertController, animated: true) {
            }
        } else if lastName.text!.isEmpty {
            presentViewController(lastNameEmptyAlertController, animated: true) {
            }
        } else if emailTextField.text!.isEmpty {
            presentViewController(emailEmptyAlertController, animated: true) {
            }
        }
        else if passwordTextField.text!.isEmpty {
            presentViewController(passwordEmptyAlertController, animated: true) {
            }
        } else if passwordTextField.text!.characters.count < 6 {
            presentViewController(invalidAlertController, animated: true) {
            }
        } else {
            activityIndicator.startAnimating()
            delay(2, closure: { () -> () in
                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("createSegue", sender: self)
                }
            )}
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
