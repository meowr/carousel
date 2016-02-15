//
//  SignInViewController.swift
//  carousel
//
//  Created by Tina Chen on 2/11/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signInButtons: UIImageView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var loginText: UIImageView!
    @IBOutlet weak var navBar: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInParentField: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    let emailEmptyAlertController = UIAlertController(title: "Email required", message: "Please enter an email address", preferredStyle: .Alert)
    let passwordEmptyAlertController = UIAlertController(title: "Password required", message: "Please enter a password", preferredStyle: .Alert)
    let invalidAlertController = UIAlertController(title: "Invalid email or password", message: "Please enter a valid email or password", preferredStyle: .Alert)
    
    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        // handle response here.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        
        buttonInitialY = signInParentField.frame.origin.y
        buttonOffset = -120
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        emailEmptyAlertController.addAction(OKAction)
        passwordEmptyAlertController.addAction(OKAction)
        invalidAlertController.addAction(OKAction)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        navBar.transform = transform
        fieldParentView.transform = transform
        navBar.alpha = 0
        fieldParentView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.navBar.transform = CGAffineTransformIdentity
            self.fieldParentView.alpha = 1
            self.navBar.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        signInParentField.frame.origin.y = buttonInitialY + buttonOffset
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -50 {
            view.endEditing(true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        signInParentField.frame.origin.y = buttonInitialY
    }
    
    @IBAction func signInButton(sender: AnyObject) {
        if emailField.text!.isEmpty {
            presentViewController(emailEmptyAlertController, animated: true) {
            }
        }
        else if passwordField.text!.isEmpty {
            print("password empty")
            presentViewController(passwordEmptyAlertController, animated: true) {
            }
        } else {
            activityIndicator.startAnimating()
            delay(2, closure: { () -> () in
                self.activityIndicator.stopAnimating()
                if self.emailField.text == "t" && self.passwordField.text == "c" {
                    print ("segue")
                    self.performSegueWithIdentifier("tutorialSegue", sender: self)
                } else {
                    self.presentViewController(self.invalidAlertController, animated: true) {}
                }
        
            })
        }
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
