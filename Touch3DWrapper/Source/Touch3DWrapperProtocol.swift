//
//  Touch3DWrapperProtocol.swift
//  Touch3DWrapper
//
//  Created by Jayesh Kawli on 3/19/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import UIKit

protocol Touch3DRecognizerProtocol {
    func actionItems() -> [UIPreviewActionItem]
    func locationFrom(point: CGPoint, in view: UIScrollView) -> CGPoint
}
