//
//  SmallViews.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class TapView: UIView {
    
    private var onClick: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func viewTapped(){
        onClick?()
    }
    
    func setOnClickAction(onClick: @escaping () -> Void) {
        self.onClick = onClick
    }
}

import Foundation
import UIKit

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 7.0

    public func setInsets(insets: UIEdgeInsets){
        topInset = insets.top
        bottomInset = insets.bottom
        leftInset = insets.left
        rightInset = insets.right
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

import Foundation
import UIKit

class ExpandedButton: UIButton {
    
    var clickIncreasedArea: CGPoint = .zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -clickIncreasedArea.x, dy: -clickIncreasedArea.y).contains(point)
    }
}

class LoadingView: UIView {
    
    private weak var spinner: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
    func startLoading(){
        if self.spinner == nil {
            let spinner = UIActivityIndicatorView()
            spinner.translatesAutoresizingMaskIntoConstraints = false
            addSubview(spinner)
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            spinner.startAnimating()
            self.spinner = spinner
        }
    }
    
    func endLoading(){
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
    }
}

class BlinkingImageView: UIView {
    
    let blinkInTime: CGFloat = 0.4
    let blinkOutTime: CGFloat = 0.4
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
    let imageView: UIImageView = {
        var imageView: UIImageView!
        if let image = UIImage(named: "badInternet_1") {
            imageView = UIImageView(image: image)
        } else {
            imageView = UIImageView(frame: .zero)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageView.alpha = 0
        blinkInAnimation()
    }
    
    private func blinkInAnimation() {
        UIView.animate(withDuration: blinkInTime) { [weak self] in
            self?.imageView.alpha = 1
        } completion: { [weak self] _ in
            self?.blinkOutAnimation()
        }
    }
    
    private func blinkOutAnimation() {
        UIView.animate(withDuration: blinkOutTime) { [weak self] in
            self?.imageView.alpha = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
