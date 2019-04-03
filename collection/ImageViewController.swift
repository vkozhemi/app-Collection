//
//  ImageViewController.swift
//  collection
//
//  Created by Volodymyr KOZHEMIAKIN on 1/18/19.
//  Copyright © 2019 MAGNUMIUM. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var label: String = ""
    private var testImage: UIImage?
    @IBOutlet weak var testScrollView: UIScrollView!
    var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(label)
        self.title = label
        
        self.testImageView = UIImageView(image: testImage)
        testScrollView.addSubview(self.testImageView)
      
        
        testScrollView.contentSize = (testImageView?.frame.size)!

        testScrollView.maximumZoomScale = 100
        testScrollView.minimumZoomScale = 0.3
        self.testScrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return testImageView
    }
    class func create(label: String, image: UIImage) -> ImageViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        vc.label = label
        vc.testImage = image
        
        return vc
    }
}
