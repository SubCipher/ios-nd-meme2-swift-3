//
//  MemeEditorViewController.swift
//  MeMe2
//
//  Created by kpicart on 2/16/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

var sourceImageView = UIImageView()
//set the prameters for the views frame size, based on its contents

var sourceImage: UIImage?{
get{
    return sourceImageView.image
}
set {
    //new properties for view
    sourceImageView.image = newValue
}
}

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate, UIScrollViewDelegate {
    
    //MARK: - set local instance of ViewSettings() and delegates
    //set local instances to access their methods
    let viewSettings = ViewSettings()
    var memeCustomRect = MemeCustomRect()
    
    let localImagePickerController = UIImagePickerController()
    let imagePickerDelegate = ImagePickerDelegate()
    
    //MARK: - Set the required IBOutlets for storyboard
    
    @IBOutlet weak var blueButtonOutlet: UIButton!
    @IBOutlet weak var redButtonOutlet: UIButton!
    @IBOutlet weak var bottomNavToolBar: UIToolbar!
    @IBOutlet weak var memePhotoBarItemOutlet: UIBarButtonItem!
    @IBOutlet weak var memeCameraBarItemOutlet: UIBarButtonItem!
    var scrollView = UIScrollView()
    
    //scrollView object to position/resize image
    internal func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sourceImageView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        localImagePickerController.delegate = imagePickerDelegate
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MemeEditorViewController.clearMeme))
        self.tabBarController?.tabBar.isHidden = true
    }
    
    internal override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //implemented here to make sure views are layouted before displayed to user
        memeCustomRect.activeFrameSize = view.frame.size
        scrollView.delegate = self
        //hide colored buttons to get more screen space
        redButtonOutlet.isHidden = !isDeviceVertical
        blueButtonOutlet.isHidden = !isDeviceVertical
        view.addSubview(scrollView)
        scrollView.addSubview(sourceImageView)
        
        //get Rect for sourceImageView
        sourceImageView.frame = memeCustomRect.getCGRectPosition("sourceImageView")
        
        setupScrollView()
        setUpTextField()
    }
    
    internal override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass == .compact {
            isDeviceVertical = false
        }
        else {
            isDeviceVertical = true
        }
    }
        
    private func setupScrollView(){
        
        //send current view frame to be calculated
        let scrollViewCGRect = memeCustomRect.getCGRectPosition("scrollView")
        scrollView.frame = scrollViewCGRect
        sourceImageView.contentMode = .scaleAspectFit
        
        scrollView.minimumZoomScale = 0.01
        scrollView.maximumZoomScale =  4.0
        scrollView.setZoomScale( 0.5, animated: true)
        scrollView.contentSize = CGSize(width: 1000.0, height: 1000.0)
    }
    
    // MARK: Cancel button implementation
    internal func clearMeme() {
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    private func setUpTextField(){
        
        
        //set XY position for textField rect
        memeCustomRect.activeFrameSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        //remove the existing textFields so we don't get mulitplicity of textfields
        memeTextField.topTextField.removeFromSuperview()
        memeTextField.bottomTextField.removeFromSuperview()
        
        memeCustomRect.setupMemeTextFields()
        memeTextField.topTextField.delegate = self
        memeTextField.bottomTextField.delegate = self
        
        view.addSubview(memeTextField.topTextField)
        view.addSubview(memeTextField.bottomTextField)
    }
    
    //MARK: - The Meme Image
    private func createMeme() -> MemeBluePrint {
        let meme = MemeBluePrint(topText: memeTextField.topTextField.text ?? "", bottomText: memeTextField.bottomTextField.text ?? "", orgImage: sourceImageView.image ?? viewSettings.noMemeImage! , memedImage: generateMemedImage())
        return meme
    }
    
    //generate Meme Image
    private func generateMemedImage() -> UIImage {
        //create the meme
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext() ?? viewSettings.noMemeImage
        
        UIGraphicsEndImageContext()
        return memedImage!
    }
    
    private func updateMemeArray(_ meme :MemeBluePrint){
        //update data source
        let object2 = UIApplication.shared.delegate
        let appDelegate2 = object2 as! AppDelegate
        appDelegate2.memes2.append(meme)
    }
    
    //Mark: - Set source device
    
    private func setMemeSourceDevice(_ senderTag: Int){
        
        //set source device based on sender.tag value, then assign its rawValue to sourceDeviceAsInt
        let sourceDevice = senderTag == 1 ?  UIImagePickerControllerSourceType.photoLibrary : UIImagePickerControllerSourceType.camera
        
        //check if sourceType is available
        if UIImagePickerController.isSourceTypeAvailable(sourceDevice){
            
            self.localImagePickerController.sourceType = (sourceDevice)
            self.present(self.localImagePickerController,animated:  true, completion: nil)
            
        } else {
            //set options to disable button for device that is not available
            let availabilityOptions = senderTag == 1 ? (memePhotoBarItemOutlet) : (memeCameraBarItemOutlet)
            availabilityOptions?.isEnabled = false
            noImageNoDevieMsg(senderTag)
        }
    }
    
    private func noImageNoDevieMsg(_ tag: Int){
        
        let useMessage = tag == 0 ? "Device is not available" : "No Image Selected, use red button to create Meme"
        let actionSheet = UIAlertController(title: "Image Source", message: useMessage , preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet,animated: true, completion: nil)
    }
    
    //MARK: - Setup buttons
    @IBAction func memeCameraBarItem(_ sender: UIBarButtonItem) {
        setMemeSourceDevice(sender.tag)
    }
    @IBAction func memePhotoBarItem(_ sender: UIBarButtonItem) {
        setMemeSourceDevice(sender.tag)
    }
    
    //this is filtered thru config func bc it uses one button for several options
    @IBAction func redButtonAction(_ sender: UIButton) {
        configImageSource(sender.tag)
    }
    
    //create meme using blue or photo bar button
    @IBAction func blueActionButton(_ sender: UIButton) {
        memeGenCheckList(sender.tag)
    }
    
    @IBAction func memeActionBarItem(_ sender: UIBarButtonItem) {
        memeGenCheckList(sender.tag)
    }
    
    //MARK: - Button actions and actionSheet alert menu
    
    //configure device/image source
    func configImageSource(_ senderTag: Int) {
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose a source", preferredStyle: .alert)
        
        //camera action alert
        actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: { (action:UIAlertAction) in
            //add one to tag delininate sources for imagepicker using single button for to generate alertAction
            self.setMemeSourceDevice(senderTag)
        }))
        
        //photo library action alert
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction)
            in self.localImagePickerController.sourceType = .photoLibrary
            self.setMemeSourceDevice(senderTag + 1)
        }))
        
        //cancel action alert
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet,animated: true, completion: nil)
    }
    
    //used to send user alert if device is not available or if user attemps to share meme with no image
    private func memeGenCheckList(_ senderTag: Int){
        if sourceImage == nil {
            //call this func with senderTag for custom msg based on device
            noImageNoDevieMsg(senderTag)
        } else {
            createMemeAction()
        }
    }
    
    private func createMemeAction(){
        
        //MARK: - Hide UI Objects
        
        //removes the keyboard to prevent cropped image, when user sends meme without exiting textField
        self.view.endEditing(true)
        
        viewSettings.hideNavButtons(true,toolBar: bottomNavToolBar, button1: redButtonOutlet, button2: blueButtonOutlet)
        
        let meme = createMeme()
        let memeActivityItems = [meme.memedImage]
        let controller = UIActivityViewController(activityItems: memeActivityItems, applicationActivities:nil)
        
        //exclude some stuff if needed
        controller.excludedActivityTypes = [UIActivityType.addToReadingList,.openInIBooks,.print]
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { (activityType, completed,items, error) in
            guard completed else { return }
            self.updateMemeArray(meme)
            self.clearMeme()
        }
        
        //unhide hide elements after meme is created
        viewSettings.hideNavButtons(false,toolBar: bottomNavToolBar, button1: redButtonOutlet, button2: blueButtonOutlet)
    }
    
    //MARK: - NotificationCenter for adjusting view when showing and hiding keyboard
    
    private func subscribeToKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications(){
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    internal func keyboardWillShow(_ notification: Notification){
        
        //set parameters for when view has to move (make space for keyboard)
        if memeTextField.bottomTextField.isEditing {
            let heightVar = !isDeviceVertical ? CGFloat(40.0) : CGFloat(10.0)
            
            self.view.frame.origin.y = heightVar - getKeyboardHeight(notification)
        } else {
            self.view.frame.origin.y = 0
        }
    }
    
    //return frame to original position
    internal func keyboardWillHide(_ notification: Notification){
        self.view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification: Notification)-> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: - delegate methods
    
    internal func textFieldDidBeginEditing(_ : UITextField) {
        //allow image push when typing in textField
        subscribeToKeyboardNotifications()
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        
        //remove form notification after editing textField
        unsubscribeFromKeyboardNotifications()
        //unsubscribeFromKeyboardNotificationsWillHide()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
