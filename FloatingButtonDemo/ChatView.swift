//
//  ChatView.swift
//  FloatingButtonDemo
//
//  Created by 陳耕霈 on 2024/4/1.
//

import Foundation
import UIKit
class ChatView: UIView {
	var chatMessage: UILabel = .init()
	var backGroundView: UIImageView = .init(frame: CGRect(x: 0, y: 0, width: 81, height: 61))
	override init(frame: CGRect) {
		super.init(frame: frame)
		let backgroundImage = UIImage(named: "Rectangle 530")
		self.addSubview(backGroundView)
		backGroundView.image = backgroundImage
		backGroundView.contentMode = .scaleToFill
		backGroundView.frame = CGRect(x: 0, y: 0, width: 81, height: 61)
		self.addSubview(chatMessage)
		setMessageUI()

	}
	func setMessageUI() {
		chatMessage.lineBreakMode = .byWordWrapping
		chatMessage.textColor = .black
		chatMessage.numberOfLines = 2
		chatMessage.contentMode = .scaleToFill
		chatMessage.translatesAutoresizingMaskIntoConstraints = false
		// 設置寬度和高度約束
		NSLayoutConstraint.activate([
			chatMessage.widthAnchor.constraint(equalToConstant: 58),
			chatMessage.heightAnchor.constraint(equalToConstant: 28)
		])
		
		NSLayoutConstraint.activate([
			chatMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			chatMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10)
		])

	}
	func config(text: String) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 0
		paragraphStyle.alignment = .center

		let attributes = NSAttributedString(string: text, attributes: [
			.font: UIFont(name: "PingFang TC", size: 10.0)!,
			.paragraphStyle: paragraphStyle
		])
		chatMessage.animateAttributedText(newText: attributes, characterDelay: 0.05)
	}

	@available(*, unavailable) required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
extension UILabel {

		func animate(newText: String, characterDelay: TimeInterval) {
				text = ""
				
				var characterIndex = 0
				let timer = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { [weak self] timer in
						if characterIndex < newText.count {
								let index = newText.index(newText.startIndex, offsetBy: characterIndex)
								self?.text?.append(newText[index])
								characterIndex += 1
						} else {
								timer.invalidate()
						}
				}
				timer.fire()
		}
	func animateAttributedText(newText: NSAttributedString, characterDelay: TimeInterval) {
					attributedText = NSAttributedString(string: "") // 开始前清空文本
					
					var characterIndex = 0
					Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { [weak self] timer in
							if characterIndex < newText.length {
									let substring = newText.attributedSubstring(from: NSRange(location: 0, length: characterIndex+1))
									self?.attributedText = substring
									characterIndex += 1
							} else {
									timer.invalidate()
							}
					}
			}
}
