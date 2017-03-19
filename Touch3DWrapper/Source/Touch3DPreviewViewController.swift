//
//  Touch3DWrapper.swift
//  Touch3DWrapper
//
//  Created by Jayesh Kawli on 3/19/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import Foundation
import UIKit

class Touch3DPreviewViewController: UIViewController {

    let touchPreviewActionItems: [UIPreviewActionItem]
    let thumbnailImage: UIImage
    let informationObject: Any

    override var previewActionItems: [UIPreviewActionItem] {
        return self.touchPreviewActionItems
    }

    init(informationObject: Any, touchPreviewActionItems: [UIPreviewActionItem], thumbnailImage: UIImage) {
        self.informationObject = informationObject
        self.touchPreviewActionItems = touchPreviewActionItems
        self.thumbnailImage = thumbnailImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView()
        imageView.image = thumbnailImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(imageView)
        let views = ["imageView": imageView]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[imageView]-64-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))

    }
}

extension UIViewController {
    func registerFor3DTouch() {
        if self.traitCollection.forceTouchCapability  == UIForceTouchCapability.available {
            if let conformingProtocolClass = self as? UIViewControllerPreviewingDelegate {
                self.registerForPreviewing(with: conformingProtocolClass, sourceView: self.view)                
            }
            print("Force touch does exist")
        } else {
            print("Force touch does not exists on this device")
        }
    }
}

