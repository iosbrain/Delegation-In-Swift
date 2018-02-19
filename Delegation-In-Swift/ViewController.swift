//
//  ViewController.swift
//  Delegation-In-Swift
//
/*
 
 Copyright (c) 2018 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 NOTE: As this code makes URL references to NASA images, if you make use of those URLs, you MUST abide by NASA's image guidelines pursuant to https://www.nasa.gov/multimedia/guidelines/index.html
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

import UIKit

// NOTE: I set auto layout constraints for the view controller
// in the storyboard corresponding to this ViewController
// for "View as: iPhone SE."

//
// This is the DELEGATE
//
class ViewController: UIViewController, LogoDownloaderDelegate
{
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var logoDownloader:LogoDownloader?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initially, the image view is hidden so we can fade it in with animation.
        imageView.alpha = 0.0

        // Initially, the login area, with username and password, are hidden
        // until the logo image downloads, and then we fade it in.
        loginView.alpha = 0.0
        
        // NASA images used pursuant to https://www.nasa.gov/multimedia/guidelines/index.html
        let imageURL: String = "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg"
        
        // Construct a LogoDownloader to download the NASA file.
        logoDownloader = LogoDownloader(logoURL: imageURL)
        // Set a reference in the delegating object, LogoDownloader, to
        // this class, ViewController. ViewController is the delegate.
        // LogoDownloader tells ViewController that the image at the NASA
        // URL has downloaded by calling the delegate method
        // didFinishDownloading(_).
        logoDownloader?.delegate = self // try nil here
        // Start the logo image download and get informed when it
        // finished downloading when didFinishDownloading(_) is called.
        logoDownloader?.downloadLogo()
        
        // Since the delegating object, LogoDownloader, has an optional
        // reference to this class, ViewController, that reference can
        // be nil, and since we use optional chaining, ViewController
        // can run with or without the delegating object.
        if logoDownloader?.delegate == nil
        {
            loginView.alpha = 1.0
        }
    } // end func viewDidLoad()

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Defining this method makes ViewController conform/adopt
    // the LogoDownloaderDelegate protocol. This method is called
    // when the logo image finished downloading.
    func didFinishDownloading(_ sender: LogoDownloader)
    {
        imageView.image = logoDownloader?.image
        
        // Animate the appearance of this ViewController's
        // user interface.
        UIView.animate(withDuration: 2.0, delay: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations:
        {
            self.loadingLabel.alpha = 0.0
            self.imageView.alpha = 1.0
        })
        { (completed:Bool) in
            if (completed)
            {
                UIView.animate(withDuration: 2.0)
                {
                    self.loginView.alpha = 1.0
                }
            }
        }
    } // end func didFinishDownloading

} // end class ViewController

