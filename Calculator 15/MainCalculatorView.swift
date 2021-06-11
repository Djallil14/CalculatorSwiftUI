//
//  MainCalculatorView.swift
//  Calculator 15
//
//  Created by Djallil Elkebir on 2021-06-10.
//

import SwiftUI

struct MainCalculatorView: View {
    @ObservedObject var calculator: CalculatorLogic
    
    var body: some View {
        ZStack {
            calculator.color.edgesIgnoringSafeArea(.all)
            GeometryReader { globalGeometry in
                VStack(spacing: 0){
                    ResultView(mainNumber: calculator.mainNumber, color: $calculator.color, globalGeometry: globalGeometry)
                    ForEach(calculator.buttons, id:\.self){ row in
                        HStack(spacing: 0) {
                            ForEach(row, id: \.self){ item in
                                switch item {
                                case .plus:
                                    Button(action:{
                                        calculator.addition()
                                    }
                                    ){
                                        OperationView(color: calculator.currentOperation == .addition ? Color.blue.opacity(0.4) : .orange, text: item.rawValue)
                                    }
                                case .minus:
                                    Button(action:{
                                        calculator.substraction()
                                    }){
                                        OperationView(color: calculator.currentOperation == .substraction ? Color.blue.opacity(0.4) : .orange, text: item.rawValue)
                                    }
                                case .multiply:
                                    Button(action:{
                                        calculator.multiply()
                                    }){
                                        OperationView(color: calculator.currentOperation == .multiply ? Color.blue.opacity(0.4) : .orange, text: item.rawValue)
                                    }
                                case .devide:
                                    Button(action:{
                                        calculator.devide()
                                    }){
                                        OperationView(color: calculator.currentOperation == .devide ? Color.blue.opacity(0.4) : .orange, text: item.rawValue)
                                    }
                                case .equal:
                                    Button(action:{
                                        calculator.equalCalculation()
                                    }){
                                        OperationView(color:.orange, text: item.rawValue)
                                    }
                                case .zero:
                                    Button(action:{
                                        calculator.addZero()
                                    }){
                                        CellView(text: item.rawValue)
                                            .frame(width: globalGeometry.size.width / 2)
                                    }
                                case .clear:
                                    Button(action:{
                                        calculator.clear()
                                    }){
                                        CellView(text: item.rawValue)
                                    }
                                case .decimal:
                                    Button(action: {
                                        if !calculator.mainNumber.contains(".") {
                                            calculator.mainNumber = "\(calculator.mainNumber)."
                                        }}){
                                            CellView(text: item.rawValue)
                                        }
                                case .negative:
                                    Button(action:{
                                        calculator.addNegative()
                                    }){
                                        CellView(text: item.rawValue)
                                    }
                                case .percent:
                                    Button(action:{
                                        calculator.percent()
                                    }){
                                        CellView(text: item.rawValue)
                                    }
                                default:
                                    Button(action:{
                                        calculator.defaultButton(item: item)
                                    }){
                                        CellView(text: item.rawValue)
                                    }
                                }
                            }
                        }
                    }
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear{
            if #available(iOS 15.0, *) {
                calculator.color = .indigo
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            MainCalculatorView(calculator: CalculatorLogic())
                .previewInterfaceOrientation(.portrait)
        } else {
            MainCalculatorView(calculator: CalculatorLogic())
        }
    }
}

struct CellView: View {
    var text: String = "1"
    var body: some View {
        if #available(iOS 15.0, *) {
            Rectangle()
                .foregroundColor(.red.opacity(0))
                .border(Color.black.opacity(0.1))
                .overlay(Text(text).font(.largeTitle).foregroundColor(.white).foregroundStyle(.secondary))
                .background(.thinMaterial, in: Rectangle())
        } else {
            Rectangle()
        }
    }
}
struct OperationView: View {
    var color: Color
    var text: String = "+"
    var body: some View{
        if #available(iOS 15.0, *) {
            Rectangle()
                .foregroundColor(color.opacity(0.5))
                .border(Color.black.opacity(0.1))
                .background(.thinMaterial).overlay(Text(text)
                                                    .font(.largeTitle).foregroundStyle(.primary).foregroundColor(.white))
        } else {
            // Fallback on earlier versions
            Rectangle()
                .foregroundColor(color.opacity(0.5) )
                .border(Color.black.opacity(0.1))
                .background(Color.white.opacity(0.5)).overlay(Text(text)
                                                                .font(.largeTitle).foregroundColor(.white.opacity(0.8)))
        }
    }
}
struct ResultView: View {
    var mainNumber: String
    @Binding var color : Color
    var globalGeometry: GeometryProxy
    var body: some View{
        if #available(iOS 15.0, *) {
            Rectangle().edgesIgnoringSafeArea(.top)
                .foregroundColor(color)
                .frame(minHeight: globalGeometry.size.height / 3)
                .overlay(HStack {
                    VStack {
                        Spacer()
                        ColorPicker("color picker", selection: $color).labelsHidden()
                    }
                    Spacer()
                    VStack{
                        Spacer()
                        Text(mainNumber)
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                    }
                }.padding())
        } else {
            Rectangle().edgesIgnoringSafeArea(.top)
                .foregroundColor(color)
                .frame(minHeight: globalGeometry.size.height / 3.5)
                .overlay(HStack {
                    Spacer()
                    VStack{
                        Spacer()
                        Text(mainNumber)
                            .font(.system(size: 96))
                            .foregroundColor(.white)
                        
                    }
                }.padding())
        }
    }
}

