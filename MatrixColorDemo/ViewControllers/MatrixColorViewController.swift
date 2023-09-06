//
//  MatrixColorViewController.swift
//  MatrixColorDemo
//
//  Created by Connor on 2023/8/20.
//

import UIKit

class MatrixColorViewController: UIViewController {
    // MARK: - Properties
    private let colorNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        lbl.text = "Unknown Color"
        return lbl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let columCount: CGFloat = CGFloat(viewModel.colors.first?.count ?? 0)
        let frame = CGRect(x: 0, y: 0, width: .zero, height: .zero)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.bounds.width / columCount, height: UIScreen.main.bounds.width / columCount)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var viewModel = MatrixColorViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Hepler
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(colorNameLabel)
        colorNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50)
        view.addSubview(collectionView)
        collectionView.anchor(top: colorNameLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50)
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MatrixColorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.colors.flatMap { $0 }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.className, for: indexPath) as? ColorCollectionViewCell, let color = viewModel.getColor(row: indexPath.row) else { return UICollectionViewCell() }
        
        cell.bindingData(color: color)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - ColorCollectionViewCellDelegate
extension MatrixColorViewController: ColorCollectionViewCellDelegate {
    func handleButtonBackgroundColor(withColor color: UIColor) {
        // returned original color
        let originalColor = color.withAlphaComponent(1)
        // same color cell show highlight
        let sameColorAraay = viewModel.getColorIndex(color: originalColor)
        for i in sameColorAraay {
            guard let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? ColorCollectionViewCell else { return }
            cell.setAnimate(sender: cell.colorButton)
        }
        
        guard let colorString = viewModel.getColorString(originalColor) else { return }
        let textFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let attributtedText = NSMutableAttributedString(string: "You Tap the ", attributes: [.font: textFont])
        attributtedText.append(NSAttributedString(string: colorString.capitalized, attributes: [.font: textFont, .foregroundColor: originalColor]))
        self.colorNameLabel.attributedText = attributtedText
    }
}
