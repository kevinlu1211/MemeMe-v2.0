//
//  ViewController.swift
//  MemeMe v2.0
//
//  Created by Kevin Lu on 25/11/2015.
//  Copyright © 2015 Kevin Lu. All rights reserved.
//

import UIKit

private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

class MemeCreatorViewController: UIViewController, UINavigationControllerDelegate, UINavigationBarDelegate, UIToolbarDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    // Could do this by adding the UIToolbar as a subview as well
    /*
    let toolBar : UIToolbar = UIToolbar(frame: CGRectMake(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>))
    self.view.addSubview(toolBar)
    */
    @IBOutlet weak var toolBar: UIToolbar!
    
    private var pickAnImageFromAlbumButton: UIBarButtonItem!
    private var pickAnImageFromCameraButton: UIBarButtonItem!
    private var cancelMemeButton: UIBarButtonItem!
    private var shareMemeButton: UIBarButtonItem!
    private var lastTouchBottomTextField: Bool!
    private var lastTouchTopTextField: Bool!
    
    
    // MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Declaring the dictionary attributes for the Meme text
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = "TOP"
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.delegate = self
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.delegate = self
        
        
        
        /* DON'T UNDERSTAND THE INTERACTION HERE, WHY CAN BOTH NEVER BE GREEN?
        // If the color is changed here then the Navigation Bar of the Navigation Controller will be changed hence if we go back then the Navigation Bar of the first controller will be changed we will have to change it back to the normal color if we want it to stay normal, but in our case we will just keep it to have UIColor.clearColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationController?.toolbar.backgroundColor = UIColor.greenColor()
        // notice how here this toolBar is local to the VC that we are currently in and when we segue back to the rootVC the color changes back to normal, whereas the navigationBar is controlled by the Navigation Controller and doesn't need to reload when we segue
        */
        
        // Creating the lengths
        let fixedLength : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixedLength.width = 20.0
        let flexibleLength : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        // Creating the buttons programmatically
        cancelMemeButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelMeme")
        pickAnImageFromAlbumButton = UIBarButtonItem(title: "Album", style: UIBarButtonItemStyle.Plain, target: self, action: "pickAnImageFromAlbum")
        shareMemeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareMeme")
        pickAnImageFromCameraButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "pickAnImageFromCamera")
        
        
        // Putting the buttons in their respective bars
        self.navigationItem.rightBarButtonItem = cancelMemeButton
        self.toolbarItems = [fixedLength, pickAnImageFromAlbumButton, flexibleLength, shareMemeButton, flexibleLength, pickAnImageFromCameraButton, fixedLength]
        toolBar.items = self.toolbarItems
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Checking if there is an image
        if (imageView.image == nil) {
            shareMemeButton.enabled = false
        }
        else {
            shareMemeButton.enabled = true
        }
        
        let tapView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "keyboardHide")
        view.addGestureRecognizer(tapView)
        lastTouchBottomTextField = false
        lastTouchTopTextField = false
        
        //         Seeing whether or not to disable the camera button
        pickAnImageFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        pickAnImageFromAlbumButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
        
        self.tabBarController?.tabBar.hidden = true
        self.subscribeToKeyboardWillShowNotifications()
        self.subscribeToKeyboardWillHideNotifications()
    }
    
    
    // Unsubscribe from the notifications
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.hidden = false
        self.unsubscribeFromKeyboardWillShowNotifications()
        self.unsubscribeFromKeyboardHideShowNotifications()
    }
    
    // This is what is called when the user taps the text field as the system automatically brings up the keyboard view
    func subscribeToKeyboardWillShowNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardHideShowNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    func unsubscribeFromKeyboardWillShowNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    deinit {
        print("MemeCreatorVC deallocated")
    }
    
    
    // MARK: Button methods
    func pickAnImageFromAlbum() {
        // Accessing the ImagePickerController
        let imagePicker = UIImagePickerController()
        // Delegates the act of getting the photos to UIImagePickerControllerDelegate, UINavigationControllerDelegate which is why these protocols are added in the class declaration
        imagePicker.delegate = self
        // Note that this sets the controller's sourceType variable to PhotoLibrary there are other things that it can be set to e.g. Camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    func pickAnImageFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func cancelMeme() {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    func shareMeme() {
        saveMeme()
        let meme : UIImage = generateMemedImage()
        let activityVC : UIActivityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    // MARK: Keyboard movement
    // this is what gets called when the user taps the view
    func keyboardHide() {
        // endEditing iterates through the subviews of our view and dismisses the keyboard which is a subview?
        print("In keyboardHide " + String(stringInterpolationSegment: self.lastTouchBottomTextField))
        self.view.endEditing(true)
    }
    
    
    
    // then this will get called as subscribeToKeyboardWillHideNotifications is called when the keyboard disappears
    func keyboardWillHide(notification: NSNotification) {
        print("In keyboardWillHide " + String(stringInterpolationSegment: self.lastTouchBottomTextField))
        if (topTextField.isFirstResponder() && lastTouchBottomTextField == true) {
            // need to move the screen down as touching the bottomTextField moves the screen up
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
        else if (topTextField.isFirstResponder() && lastTouchBottomTextField == false) {
            // do nothing as the screen as touched view first then touched topTextField
        }
        else if (bottomTextField.isFirstResponder() && lastTouchTopTextField == false){
            // need to move the screen down as we move the screen up when touching bottomTextField
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
        else if (bottomTextField.isFirstResponder() && lastTouchTopTextField == true) {
            // do nothing as if the last touched thing was topTextField then the screen would have already moved so don't need to move it up again
            
        }
        lastTouchBottomTextField = false
        lastTouchTopTextField = false
    }
    
    
    
    // This is called when the user touches one of the textFields
    func keyboardWillShow(notification: NSNotification) {
        if(topTextField.isFirstResponder()) {
            lastTouchTopTextField = true
        }
        else if (bottomTextField.isFirstResponder() && lastTouchTopTextField == false) {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            lastTouchBottomTextField = true
        }
        else if (bottomTextField.isFirstResponder() && lastTouchTopTextField == true) {
            lastTouchTopTextField = false
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    // MARK: Saving Meme
    func saveMeme() {
        let meme = Meme(topTextFieldString: topTextField.text!, bottomTextFieldString: bottomTextField.text!, originalImage: imageView.image!, memeImage: generateMemedImage())
        //        let savedMeme : UIImage = meme.memeImage
        //        UIImageWriteToSavedPhotosAlbum(savedMeme, nil, nil, nil)
        

        // Adding the meme to the Appdelegate
        appDelegate.memes.append(meme)
        print("Meme appended")
        print(appDelegate.memes.count)
        
    }
    func generateMemedImage() -> UIImage {
        let newImageViewOriginAndDimension = self.view.frame
        let originalImageViewOriginAndDimension = imageView.frame
        // Rescaling imageView first to avoid showing self.view
        rescaleImageView(newImageViewOriginAndDimension)
        hideBars()
        let memedImage = screenShot()
        rescaleImageView(originalImageViewOriginAndDimension)
        showBars()
        return memedImage
        
    }
    func hideBars() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        toolBar.hidden = true
    }
    func rescaleImageView(originAndDimension : CGRect) {
        imageView.frame = originAndDimension
        print(imageView.frame)
    }
    func screenShot() -> UIImage{
        // Pushes the size of the view onto the stack
        UIGraphicsBeginImageContext(self.view.frame.size)
        // Essentially takes a screenshot of the area of view.frame
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Cropping the image so that self.view won't show
        let cropRect = CGRectMake(0, 30, memedImage.size.width, memedImage.size.height)
        let newMemedImageCGI = CGImageCreateWithImageInRect(memedImage.CGImage, cropRect)
        let newMemedImage = UIImage(CGImage: newMemedImageCGI!)
        return newMemedImage
    }
    func showBars() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        toolBar.hidden = false
    }
}

// MARK: Protocols for UITextFieldDelegate
extension MemeCreatorViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {

        if (textField.text != "TOP" && textField.text != "BOTTOM") {
            // do nothing
        }
        else {
            textField.text = ""
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        if (textField.text == "") {
            if (textField == topTextField) {
                textField.text = "TOP"
            }
            else if (textField == bottomTextField) {
                textField.text = "BOTTOM"
            }
        }

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        keyboardHide()
        return false
    }
}

// MARK: Protocols for UIImagePickerControllerDelegate
extension MemeCreatorViewController : UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

