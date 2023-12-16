//
//  ContentView.swift
//  HW-4.2-DY
//
//  Created by Denis Yarets on 16/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var valueRed: Float = 255
    @State private var valueGreen: Float = 255
    @State private var valueBlue: Float = 255
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: Double(valueRed / 255), green: Double(valueGreen / 255), blue: Double(valueBlue / 255)))
                .stroke(.white, lineWidth: 2)
                .frame(height: 150)
                .padding(.bottom, 40)
            
            VStack(spacing: 10) {
                ColorComponentView($valueRed, color: .red)
                ColorComponentView($valueGreen, color: .green)
                ColorComponentView($valueBlue, color: .blue)
            }
            
            Spacer()
        }
        .padding()
        .background(.blue.opacity(0.8))
        
    }
}

#Preview {
    ContentView()
}

struct ColorComponentView: View {
    
    @Binding var value: Float
    let color: Color
    
    @State private var text: String
    @State private var valuePrevious: Int
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    
    init(_ value: Binding<Float>, color: Color) {
        self._value = value
        self.color = color
        
        text = String(value.wrappedValue.formatted())
        valuePrevious = Int(value.wrappedValue)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(value.formatted())")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 35, alignment: .leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { _, newValue in
                    text = String(newValue.formatted())
                    valuePrevious = Int(newValue)
                }
            
            TextField("", text: $text)
                .modified($isFocused)
                .onChange(of: isFocused) { if !$1 { update() } }
                .alert("Wrong Format", isPresented: $showAlert) {
                    Button("OK") { showAlert.toggle() }
                }
        }
       
       
    }
    
    private func update() {
        if let value = Double(text) {
            if !(0...255.0).contains(value) {
                failure()
            } else {
                success()
            }
        } else {
            failure()
        }
    }
    
    private func success() {
        let valueInt = Int(text) ?? 0
        text = String(valueInt)
        valuePrevious = valueInt
        value = Float(valueInt)
    }
    
    private func failure() {
        showAlert.toggle()
        text = String(valuePrevious)
    }
}


