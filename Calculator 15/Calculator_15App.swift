//
//  Calculator_15App.swift
//  Calculator 15
//
//  Created by Djallil Elkebir on 2021-06-10.
//

import SwiftUI

@main
struct Calculator_15App: App {
    var body: some Scene {
        WindowGroup {
            MainCalculatorView(calculator: CalculatorLogic())
        }
    }
}
