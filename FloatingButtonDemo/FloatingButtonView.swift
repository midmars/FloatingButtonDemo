//
//  FloatingButtonView.swift
//  FloatingButtonDemo
//
//  Created by 陳耕霈 on 2024/4/1.
//

import Foundation
import UIKit
protocol FloatingButtonViewDelegate: AnyObject {
	func btnViewClick()
}

class FloatingButtonView: UIView {
	var canPanMove: Bool = true
	var targetView: UIView?
	private let screenWidth = UIScreen.main.bounds.width
	private let screenHeight = UIScreen.main.bounds.height
	weak var delegate: FloatingButtonViewDelegate?
	var characterImage: UIImageView = .init(frame: CGRect(x: 40, y: 30, width: 71, height: 64))
	var chatView = ChatView(frame: CGRect(x: 0, y: 0, width: 81, height: 61))
	var chatBtn: UIButton = .init()
	convenience init(frame: CGRect, canPanMove: Bool) {
		self.init(frame: frame)
		self.canPanMove = canPanMove
		configGesture()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		let character = UIImage(named: "happy")
		characterImage.image = character
		characterImage.contentMode = .scaleToFill
		self.addSubview(chatView)
		self.addSubview(characterImage)
		chatView.config(text: "Hello 你好")
	}

	@available(*, unavailable) required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configGesture() {
		if canPanMove {
			let panner = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
			panner.minimumNumberOfTouches = 1
			self.addGestureRecognizer(panner)
		}
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
		self.addGestureRecognizer(tapGesture)
	}

	@objc func handleTapGesture(_: UITapGestureRecognizer) {
		delegate?.btnViewClick()
	}

	@objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
		// 取得手勢位置
		let location = gesture.location(in: targetView)
		if gesture.state == .changed {
			self.center = location
		}
		if gesture.state == .ended {
			var lineBtnRect = self.frame
//			右邊
			if location.x >= screenWidth / 2 {
				lineBtnRect.origin.x = screenWidth - self.frame.width
//			左邊
			} else {
				lineBtnRect.origin.x = 0
			}
//			上
			if location.y - self.frame.height / 2 < 44 {
				lineBtnRect.origin.y = 44
			} else if location.y + self.frame.height / 2 > screenHeight - 44 {
				lineBtnRect.origin.y = screenHeight - 44 - self.frame.height - 5
			}
			UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
				self.frame = lineBtnRect
			})
		}
	}

	func addFloatingButton(target: UIView) {
		self.targetView = target
	}
	
}
