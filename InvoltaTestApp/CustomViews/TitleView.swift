//
//  TitleView.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class TitleView: UIView {
    
    private var safeAreaIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "topSafeAreaSet")
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Involta Team"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "mainTextColorSet_1")
        label.textAlignment = .center
        return label
    }()
    
    private var bottomSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.593780458, green: 0.4573963284, blue: 0.9553021789, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "mainColorSet_2")
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 2, height: 1)
        layer.shadowRadius = 10
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        addSubview(safeAreaIndicator)
        safeAreaIndicator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        safeAreaIndicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        safeAreaIndicator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        safeAreaIndicator.heightAnchor.constraint(equalToConstant: AppConstants.safeAreaPadding.top).isActive = true
        
        let textHeight = label.text!.height(width: AppConstants.screenWidth, font: label.font)
        let textTopPoint: CGFloat = (GeneralUIConstants.titleViewHeightAboveSafeArea - textHeight) / 2 + AppConstants.safeAreaPadding.top
        
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: textTopPoint).isActive = true
        
        addSubview(bottomSeparator)
        bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
