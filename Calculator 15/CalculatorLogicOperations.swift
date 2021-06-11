//
//  ViewModel.swift
//  Calculator 15
//
//  Created by Djallil Elkebir on 2021-06-11.
//

import SwiftUI

class CalculatorLogic: ObservableObject {
    @Published var buttons: [[CalculatorModel]] = [[.clear,.negative,.percent,.devide],
                                                  [.seven,.eight,.nine,.multiply],
                                                  [.four,.five,.six,.minus],
                                                  [.one,.two,.three,.plus],
                                                  [.zero,.decimal,.equal]]
    @Published var currentOperation: Operations? = nil
    @Published var mainNumber: String = "0" {
        // Main Number can't be higher than 9 digits
        didSet{
            if mainNumber.count > 9 {
                mainNumber = String(mainNumber.prefix(9))
            }
        }
    }
    @Published var firstOperand: String = ""
    @Published var secondOperand: String = ""
    @Published var color: Color = .black
    @Published var newOperation: Bool = false
    
    func addition(){
        if currentOperation != .addition{
            firstOperand = mainNumber
            currentOperation = .addition
            newOperation.toggle()
        } else {
            secondOperand = mainNumber
            equalCalculation()
            currentOperation = nil
        }
    }
    func substraction(){
        if currentOperation != .substraction{
            firstOperand = mainNumber
            currentOperation = .substraction
            newOperation.toggle()
        } else {
            secondOperand = mainNumber
            equalCalculation()
            currentOperation = nil
        }
    }
    func multiply(){
        if currentOperation != .multiply{
            firstOperand = mainNumber
            currentOperation = .multiply
            newOperation.toggle()
        } else {
            secondOperand = mainNumber
            equalCalculation()
            currentOperation = nil
        }
    }
    func devide(){
        if currentOperation != .devide{
            firstOperand = mainNumber
            currentOperation = .devide
            newOperation.toggle()
        } else {
            secondOperand = mainNumber
            equalCalculation()
            currentOperation = nil
        }
    }
    func addZero(){
        if mainNumber != "0" {
            if !newOperation{
                mainNumber.append("0")
            } else {
                mainNumber = "0"
                newOperation.toggle()
            }
        } else {
            mainNumber = "\(0)"
        }
    }
    func addNegative(){
        if mainNumber.contains("-"){
            mainNumber = String(mainNumber.dropFirst())
        } else {
            mainNumber = "-\(mainNumber)"
        }
    }
    func defaultButton(item: CalculatorModel){
        if mainNumber != "0"{
            if !newOperation{
                mainNumber.append(item.rawValue)
            } else {
                mainNumber = item.rawValue
                newOperation.toggle()
            }
        } else {
                mainNumber = item.rawValue
        }
    }
    func percent(){
        if mainNumber != "0"{
            mainNumber = "0.0\(mainNumber)"
        }
    }
    
    func clear(){
        mainNumber = "0"
        currentOperation = nil
        firstOperand = ""
        secondOperand = ""
        newOperation = false
    }
    func equalCalculation(){
        var totalDouble: Double = 0
        secondOperand = mainNumber
        switch currentOperation {
        case .addition:
            totalDouble = (Double(firstOperand) ?? 0) + (Double(secondOperand) ?? 0)
        case .substraction:
            totalDouble = (Double(firstOperand) ?? 0) - (Double(secondOperand) ?? 0)
        case .devide:
            totalDouble = (Double(firstOperand) ?? 0) / (Double(secondOperand) ?? 0)
        case .multiply:
            totalDouble = (Double(firstOperand) ?? 0) * (Double(secondOperand) ?? 0)
        case .none:
            break
        case .percent:
            totalDouble = Double((Int(firstOperand) ?? 0) % (Int(secondOperand) ?? 0))
        case .negative:
            mainNumber = "-\((Double(firstOperand) ?? 0))"
        }
        let totalString = totalDouble.stringWithoutZeroFraction
        mainNumber = totalString
        currentOperation = nil
    }
    
}
extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

