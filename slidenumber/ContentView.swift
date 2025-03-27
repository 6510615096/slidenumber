//
//  ContentView.swift
//  slidenumber
//
//  Created by นางสาวณัฐภูพิชา อรุณกรพสุรักษ์ on 26/3/2568 BE.
//  Created by นางสาวพรนัชชา ประทีปสังคม on 26/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = Array(0..<16).shuffled()
    @State private var moveCount = 0
    @State private var gameCompleted = false
    @State private var isShuffling = false
    
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
                            .font(.largeTitle).fontWeight(.medium)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.pink, lineWidth: 2))
                            .opacity(isShuffling ? 1 : 1)
                            .animation(.easeInOut(duration: 0.4), value: numbers)
                            .onTapGesture {
                                if let tappedIndex = numbers.firstIndex(of: index) {
                                    moveTile(from: tappedIndex)
                                }
                            }

                    } else {
                        Color.clear
                            .frame(width: 90, height: 90)
                            .onTapGesture {
                                if let tappedIndex = numbers.firstIndex(of: index) {
                                    moveTile(from: tappedIndex)
                                }
                            }

                    }
                }
            }
            .padding(10)
            Spacer()
            
            if gameCompleted == true {
                Text("You Won!!!")
                    .foregroundStyle(Color.red)
                    .font(.largeTitle).fontWeight(.semibold)
            }
            
            Text("Moves: \(moveCount)")
                .foregroundStyle(Color.purple)
                .font(.title).fontWeight(.medium)
            
            Button("New Game") {
                isShuffling = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        numbers.shuffle()
                        moveCount = 0
                        gameCompleted = false
                        isShuffling = false
                    }
                }
            }
            .padding()
            .background(Color.purple).opacity(0.7)
            .foregroundColor(.white)
            .cornerRadius(12)
            .font(.title2).fontWeight(.bold)
        }
    }
    
    func moveTile(from index: Int) {
        guard let emptyIndex = numbers.firstIndex(of: 0) else { return }
        
        let row = index / 4
        let col = index % 4
        let emptyRow = emptyIndex / 4
        let emptyCol = emptyIndex % 4
        
        if (row == emptyRow && abs(col - emptyCol) == 1) || (col == emptyCol && abs(row - emptyRow) == 1) {
            withAnimation(.easeInOut(duration: 0.2)) {
                numbers.swapAt(index, emptyIndex)
                moveCount += 1
            }
            
            if isGameCompleted() {
                gameCompleted = true
            }
        }
    }
    
    func isGameCompleted() -> Bool {
        return numbers == Array(1...15) + [0]
    }
}


#Preview {
    ContentView()
}
