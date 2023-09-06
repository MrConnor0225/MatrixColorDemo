//
//  MatrixColorViewModel.swift
//  MatrixColorDemo
//
//  Created by Connor on 2023/8/21.
//

import Foundation
import UIKit

class MatrixColorViewModel {
    // MARK: - Properties
    var colors: [[String]] = []
    var model: ColorModel?
    // MARK: - Initialize
    init() {
        fetchData()
    }
    
    // MARK: - Public Method
    func getColor(row: Int) -> UIColor? {
        let colorArray: [String] = colors.flatMap { $0 }
        return colorFromString(colorArray[row])
    }
    
    func getColorIndex(color: UIColor) -> [Int] {
        let colorArray: [String] = colors.flatMap { $0 }
        var indexArray: [Int] = []
        for i in colorArray.indices {
            if self.getColorString(color) == colorArray[i] {
                indexArray.append(i)
            }
        }
        return indexArray
    }
    
    func getColorString(_ color: UIColor) -> String? {
        switch color {
        case .blue: return "blue"
        case .black: return "black"
        case .yellow: return "yellow"
        case .purple: return "purple"
        case .green: return "green"
        case .red: return "red"
        default: return "Unknown Color"
        }
    }
    
    // MARK: - Helper
    private func fetchData() {
        let mockURL = URL(string: "https:mock.com")!
        NetworkHelper.shared.fetchData(from: mockURL) { (colorData, error) in
            if let error {
                print("DEBUG error jsonfile : \(error)")
                return
            }
            
            guard let colorData else { return }
            self.colors = colorData.results

        }
    }
    
    private func colorFromString(_ colorString: String) -> UIColor? {
        switch colorString {
        case "blue": return .blue
        case "black": return .black
        case "yellow": return .yellow
        case "purple": return .purple
        case "green": return .green
        case "red": return .red
        default: return nil
        }
    }

}
