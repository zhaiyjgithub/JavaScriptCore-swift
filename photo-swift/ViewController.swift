//
//  ViewController.swift
//  photo-swift
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController,UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,takePhotoDelegate{
    let imageView = UIImageView(frame: CGRect(x: 100, y: 20, width: 80, height: 80))
    let imagePicker = UIImagePickerController()
    let webView = UIWebView(frame: CGRect(x: 0, y: 100, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self;
        
        let path = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let url = NSURL(fileURLWithPath: path!)
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        view.addSubview(webView)

        view.addSubview(imageView)
        
        imagePicker.editing = true
        imagePicker.sourceType = .Camera
        imagePicker.delegate  = self
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print("finshed load")
        let context = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as!  JSContext
        
        let kson = Student()
        kson.delegate = self
        
        context.setObject(kson, forKeyedSubscript:"Student")
        context.exceptionHandler = { context, exception in
            print("JS Error: \(exception)")
        }
        
        let script = "function spring () {document.write(\"kson\");Student.takePhoto();}var btn = document.getElementById(\"pid\");btn.addEventListener('click', spring);";
        context.evaluateScript(script)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func gotoTakePhoto() {
        print("goto take photo");
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

