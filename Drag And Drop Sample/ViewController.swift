//
//  ViewController.swift
//  Drag And Drop Sample
//
//  Created by Yurii Chukhlib on 06.09.2017.
//  Copyright © 2017 D4. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addInteraction(UIDropInteraction(delegate: self))
	}
	
	func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
		for dragItem in session.items { // (1)
			dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { object, error in // (2)
				
				guard error == nil else { return print("Failed to load our dragged item") } // (3)
				guard let draggedImage = object as? UIImage else { return } // (4)
				
				DispatchQueue.main.async { // (5)
					let imageView = UIImageView(image: draggedImage) // (6)
					self.view.addSubview(imageView)
					imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
					
					let centerPoint = session.location(in: self.view)
					imageView.center = centerPoint
				}
			})
		}
	}
	
	func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
		return UIDropProposal(operation: .copy)
	}
	
	func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
		return session.canLoadObjects(ofClass: UIImage.self)
	}
	
}

