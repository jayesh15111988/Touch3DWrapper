
//
//  ImageViewController.swift
//  Touch3DWrapper
//
//  Created by Jayesh Kawli on 3/19/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageName)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelViewController))
    }

    @objc func cancelViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
