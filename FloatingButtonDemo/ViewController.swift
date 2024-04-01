//
//  ViewController.swift
//  FloatingButtonDemo
//
//  Created by 陳耕霈 on 2024/3/27.
//

import UIKit

class ViewController: UIViewController, FloatingButtonViewDelegate {
	@IBOutlet weak var testField: UITextField!
	private let floatingButton = FloatingButtonView(frame: .zero, canPanMove: true)
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.testField.backgroundColor = .white
		self.testField.borderStyle = .roundedRect
		self.testField.layer.borderWidth = 1
		self.testField.layer.borderColor = UIColor.green.cgColor
		view.addSubview(floatingButton)
		floatingButton.addFloatingButton(target: self.view)
		floatingButton.delegate = self
	}
	@IBAction func testLabelAnimation(_ sender: Any) {
		guard let text = testField.text else { return}
		guard !text.isEmpty else { return }
		floatingButton.chatView.config(text: text)
	}
	func btnViewClick() {
		print("click view")
	}

	override func viewDidLayoutSubviews() {
		floatingButton.frame = CGRect(x: view.frame.size.width - 150, y: view.frame.size.height - 120, width: 117, height: 87)
	}
}


