//
//  LargeImageViewController.swift
//  Progress Journal
//
//  Created by Aleksander Waage on 25/06/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController {
    
    var progressUpdateItem: ProgressUpdate? = nil
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let progressUpdateItem = progressUpdateItem {
            title = progressUpdateItem.title
            if let imageData = progressUpdateItem.image {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
}
