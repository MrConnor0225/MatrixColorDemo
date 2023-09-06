//
//  ColorCollectionViewCell.swift
//  MatrixColorDemo
//
//  Created by Connor on 2023/8/20.
//

import UIKit

protocol ColorCollectionViewCellDelegate: AnyObject {
    func handleButtonBackgroundColor(withColor color: UIColor)
}

class ColorCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var colorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("", for: .normal)
        btn.addTarget(self, action: #selector(handleButtonClick(sender:)), for: .touchUpInside)
        btn.backgroundColor = .orange
        return btn
    }()
    
    weak var delegate: ColorCollectionViewCellDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helper
    func setupUI() {
        contentView.addSubview(colorButton)
        colorButton.anchor(top: contentView.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func setAnimate(sender: UIButton) {
        guard let originalColor = sender.backgroundColor else { return }
        UIView.animate(withDuration: 0.2, animations: {
            sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = originalColor
            })
        }
    }
    
    func bindingData(color: UIColor) {
        colorButton.backgroundColor = color
    }
    
    // MARK: - Actions
    @objc
    func handleButtonClick(sender: UIButton) {
        setAnimate(sender: sender)
        guard let buttonColor = colorButton.backgroundColor else { return }
        self.delegate?.handleButtonBackgroundColor(withColor: buttonColor)
    }
    
}
