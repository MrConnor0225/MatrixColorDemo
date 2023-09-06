//
//  MatrixColorDemoTests.swift
//  MatrixColorDemoTests
//
//  Created by Connor on 2023/8/21.
//

import XCTest
@testable import MatrixColorDemo

final class MatrixColorDemoTests: XCTestCase {
    
    func testGetColor() {
        
        let viewModel = MatrixColorViewModel()
        viewModel.colors = [["blue", "black"], ["yellow", "purple"]]
        let color1 = viewModel.getColor(row: 0)
        XCTAssertEqual(color1, UIColor.blue)
        
        let color2 = viewModel.getColor(row: 1)
        XCTAssertEqual(color2, UIColor.black)
        
    }
    
    func testGetString() {
        let viewModel = MatrixColorViewModel()
        
        let yellowString = viewModel.getColorString(.yellow)
        XCTAssertEqual(yellowString, "yellow")
        
        let unknowColorString = viewModel.getColorString(.systemRed)
        XCTAssertEqual(unknowColorString, "Unknown Color")
        
    }

}
