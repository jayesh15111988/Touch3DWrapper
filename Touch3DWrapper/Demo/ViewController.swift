//
//  ViewController.swift
//  Touch3DWrapper
//
//  Created by Jayesh Kawli on 3/19/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import UIKit

enum Player: String {
    case wawrinka
    case nadal
    case federer
    case djoko
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var playersList: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerFor3DTouch()
        playersList = [.wawrinka, .nadal, .federer,. djoko]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.playersList[indexPath.row].rawValue
        return cell
    }
}

extension ViewController: UIViewControllerPreviewingDelegate, LongPressRecognizerProtocol {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        if let _ = self.presentedViewController as? Touch3DPreviewViewController {
            return nil
        }

        var updatedLocation = self.view.convert(location, to: self.tableView)
        updatedLocation = CGPoint(x: updatedLocation.x, y: updatedLocation.y + self.tableView.contentOffset.y)

        if let indexPath = tableView.indexPathForRow(at: updatedLocation), let cell = self.tableView.cellForRow(at: indexPath) {
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            previewingContext.sourceRect = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.bounds.width, height: cell.bounds.height)
            let selectedPlayerNameString = self.playersList[indexPath.row].rawValue
            let thumbnailImage = UIImage(named: selectedPlayerNameString)
            if let thumbnailImage = thumbnailImage {
                let previewViewController = Touch3DPreviewViewController(informationObject: selectedPlayerNameString, touchPreviewActionItems: self.actionItems(), thumbnailImage: thumbnailImage)
                return previewViewController
            }
            return nil
        }

        return nil
    }

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let previewVC = viewControllerToCommit as? Touch3DPreviewViewController {
            if let imageName = previewVC.informationObject as? String {
                if let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "image") as? ImageViewController {
                    imageViewController.imageName = imageName
                    let navController = UINavigationController(rootViewController: imageViewController)
                    self.present(navController, animated: true, completion: nil)

                }
            }
        }
    }

    func actionItems() -> [UIPreviewActionItem] {
        let addToCartAction = UIPreviewAction(title: "Perform Action 1", style: .default) { (action, controller) in
            print("Action 1 performed")
        }

        let addToIdeaboardAction = UIPreviewAction(title: "Perform Action 2", style: .default) { (action, controller) in
            print("Action 2 Performed")
        }

        let action2 = UIPreviewAction(title: "Cancel", style: .destructive) { (action, controller) in
            print("Action Cancelled")
        }

        let actionGroup = UIPreviewActionGroup(title: "More Actions", style: .default, actions: [addToCartAction, addToIdeaboardAction, action2])

        let finalArray = NSArray.init(object: actionGroup)
        return finalArray as! [UIPreviewActionItem]
    }
}

