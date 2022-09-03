//
//  ContentView.swift
//  BrainGame
//
//  Created by miffy on 2022/09/02.
//

import SwiftUI


struct ContentView: View {
    let moves = ["✋", "✌️","✊"]
    
    @State private var shouldWin = Bool.random() ? "WIN" : "LOSE"
    @State private var cur = Int.random(in: 0...2)
    @State private var usersAnswer = 0
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingResult = false
    
    
    private var correctAnswer: Int {
            return (shouldWin == "WIN") ? ( (cur + 1) % 3) : ((cur + 2) % 3)
    }
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [.orange, .pink]), center: .center, startRadius: 1, endRadius: 400)
                        .ignoresSafeArea()
            
            VStack{
                Spacer()
                Section{
                    Text("Computer plays")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                    
                    Text("\(self.moves[cur])")
                        .font(.system(size: 200))
                                        
                }
                
                Spacer()
                Text("To " + shouldWin)
                    .font(.title.bold())
                Text("You play")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy))
                    
                
                
                
                HStack{
                
                    ForEach(0..<3) { number in
                        Button{
                            ansTapped(usersAnswer: number)
                        }label: {
                            Text(moves[number])
                                .modifier(ButtonStyle())
                            
                        }
                    }
                }
                
                
                Spacer()
                Text("Score: \(self.score)")
                    .font(.title.bold())
                    .frame(maxWidth: 300)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
            
            
            }
            .alert(scoreTitle, isPresented: $showingResult) {
                Button("Continue", action: continueGame)
                
            } message: {
                Text("Your score \(self.score)")
            }
        
        }
    }
    
    func ansTapped(usersAnswer: Int) {
            if usersAnswer == self.correctAnswer {
                score += 1
                scoreTitle = "Correct"
            } else {
                score -= 1
                scoreTitle = "Incorrect"
            }
            showingResult = true
    }
    
    func continueGame() {
            cur = Int.random(in: 0...2)
            shouldWin =  Bool.random() ? "WIN" : "LOSE"
    }
    
    
    struct ButtonStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .frame(width: 90, height: 60, alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
        }
    }

    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
