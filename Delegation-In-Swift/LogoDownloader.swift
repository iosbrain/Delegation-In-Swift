//
//  LogoDownloader.swift
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

import Foundation

import UIKit

//
// This is the DELEGATING CLASS. An instances of this
// class is a DELEGATING OBJECT.
//
class LogoDownloader
{
    
    var logoURL:String
    
    var image:UIImage?
    
    var delegate:LogoDownloaderDelegate?
    
    init(logoURL:String)
    {
        self.logoURL = logoURL
    }
    
    func downloadLogo() -> Void
    {
        // Start the image download task asynchronously by submitting
        // it to the default background queue; this task is submitted
        // and DispatchQueue.global returns immediately.
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async
        {
                
            // I'm PURPOSEFULLY downloading the image using a synchronous call
            // (NSData), but I'm doing so in the BACKGROUND.
            let imageURL = URL(string: self.logoURL)
            let imageData = NSData(contentsOf: imageURL!)
            self.image = UIImage(data: imageData! as Data)
            print("image downloaded")

            // Once the image finishes downloading, I jump onto the MAIN
            // THREAD TO UPDATE THE UI.
            DispatchQueue.main.async
            {
                // Tell the delegate that the image
                // has downloaded so the delegate can
                // display the image.
                self.didDownloadImage()
            }
                
        } // end DispatchQueue.global
    }
    
    // Since this class has a reference to the delegate,
    // "at the appropriate time [it] sends a message to" the delegate.
    // Finishing the logo download is definitely
    // the appropriate time.
    func didDownloadImage()
    {
        delegate?.didFinishDownloading(self)
    }
    
} // end class LogoDownloader
