//
//  ContentView.swift
//  slidenumber
//
//  Created by นางสาวณัฐภูพิชา อรุณกรพสุรักษ์ on 26/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = Array(0..<16).shuffled()
    @State private var moveCount = 0
    
    var body: some View {
        VStack {
            Text("Slide Number Puzzle")
                .foregroundColor(Color.purple)
                .font(.largeTitle).fontWeight(.semibold)
                .padding(30)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(numbers, id: \ .self) { index in
                    if index != 0 {
                        Text("\(index)")
                            .frame(width: 90, height: 90)
                            .background(Color.white).opacity(0.7)
                            .foregroundColor(.pink)
                            .font(.largeTitle)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.pink, lineWidth: 2))
                            .onTapGesture {
                                moveTile(from: index)
                            }
                    } else {
                        Color.clear
                            .frame(width: 90, height: 90)
                            .onTapGesture {
                                moveTile(from: index)
                            }
                    }
                }
            }
            .padding(10)
            Spacer()
            
            
            Text("Moves: \(moveCount)")
                .foregroundStyle(Color.blue)
                .font(.title).fontWeight(.medium)
            
            Button("Reset") {
                            numbers.shuffle()
                            moveCount = 0
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.title2)
        }
    }
    
    func moveTile(from index: Int) {
        guard let emptyIndex = numbers.firstIndex(of: 0) else { return }
        
        let row = index / 4
        let col = index % 4
        let emptyRow = emptyIndex / 4
        let emptyCol = emptyIndex % 4
        
        print("array: \(numbers)")
        print("row: \(row)")
        print("col: \(col)")
        print("emptyRow: \(emptyRow)")
        print("emptyCol: \(emptyCol)")
        print("Clicked index: \(index)")
        print("Clicked number: \(numbers[index])")
        
        // ตรวจสอบว่า index ที่คลิกสามารถสลับกับตำแหน่งที่ว่างได้
        if (row == emptyRow && abs(col - emptyCol) == 1) || (col == emptyCol && abs(row - emptyRow) == 1) {
            // สลับตำแหน่ง
            numbers.swapAt(index, emptyIndex)
            moveCount += 1
        }
    }
}


#Preview {
    ContentView()
}
