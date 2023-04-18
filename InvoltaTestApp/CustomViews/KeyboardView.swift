//
//  KeyboardView.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

// MARK: SearchTitleView
class KeyboardView: UIView {
    
    var searchTextField = InsertableTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "keyboardHolder")
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init() - coder has not been implemented")
    }
    
    private func makeConstraints(){
        
        addSubview(searchTextField)
        searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: GeneralUIConstants.keyboardInsets.top).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GeneralUIConstants.keyboardInsets.left).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GeneralUIConstants.keyboardInsets.right).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: GeneralUIConstants.keyboardHeightAboveSafeArea).isActive = true
    }
}
// MARK: InsertableTextField
class InsertableTextField: UITextField, UITextFieldDelegate{

    weak var textChangedDelegate: InsertableTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "keyboardField")
        placeholder = "Type in message"
        font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textColor = UIColor(named: "keyboardText")
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true

        leftViewMode = .always
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        leftView = leftPadding
        
        setUpOnTextEdited()
    }

    private func setUpOnTextEdited(){
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        textChangedDelegate?.onTextChanged(text: text, isNotEmpty: !text.isEmpty)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            return true
        }
        print("TF resigned and passed text: \(text)")
        textChangedDelegate?.onReturnButtonPressed(for: text)
        textField.text = ""
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error with coder")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
}

protocol InsertableTextFieldDelegate: AnyObject {
    func onTextChanged(text: String, isNotEmpty: Bool)
    func onReturnButtonPressed(for text: String)
}
