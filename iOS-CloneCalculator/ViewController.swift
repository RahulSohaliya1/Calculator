//
//  ViewController.swift
//  iOS-CloneCalculator
//
//  Created by DREAMWORLD on 03/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    var currentNumber: Double = 0
    var previousNumber: Double?
    var operation: String = ""
    var isPerformingOperation: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            let corner = min(button.bounds.height, button.bounds.width) / 2.50
            button.layer.cornerRadius = corner
            button.clipsToBounds = true
        }
    }
    func calculateResult() {
        if let displayText = numberLabel.text, let currentNumber = Double(displayText) {
            switch operation {
            case "+":
                previousNumber! += currentNumber
            case "-":
                previousNumber! -= currentNumber
            case "x":
                previousNumber! *= currentNumber
            case "÷":
                previousNumber! /= currentNumber
            default:
                break
            }
            numberLabel.text = formatNumber(previousNumber!)
        }
    }
    
    
    func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        } else {
            return String(format: "%.2f", number)
        }
    }
    
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        numberLabel.text = ""
        previousNumber = nil
        operation = ""
        isPerformingOperation = false
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        guard let numberText = sender.titleLabel?.text else {
            return
        }
        
        if isPerformingOperation {
            numberLabel.text = numberText
            isPerformingOperation = false
        } else {
            if let currentDisplayText = numberLabel.text {
                numberLabel.text = currentDisplayText + numberText
            } else {
                numberLabel.text = numberText
            }
        }
    }
    
    @IBAction func operatorButtonClicked(_ sender: UIButton) {
        guard let operationText = sender.titleLabel?.text else {
            return
        }
        
        if let displayText = numberLabel.text, let number = Double(displayText) {
            if operationText == "%" {
                currentNumber = number / 100.0
                numberLabel.text = formatNumber(currentNumber)
                isPerformingOperation = true
            } else if operationText == "=" {
                if let previousNumber = previousNumber {
                    calculateResult()
                }
            } else if operationText == "+/-" {
                currentNumber = -number
                numberLabel.text = formatNumber(currentNumber)
            } else {
                if operation.isEmpty {
                    previousNumber = number
                } else {
                    calculateResult()
                }
                operation = operationText
                isPerformingOperation = true
            }
        }
    }
}








