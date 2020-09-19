//
//  ContentView.swift
//  Edutainment
//
//  Created by Rafael Calunga on 2020-09-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var maxMultiplicationTable  = 1
    @State private var numberOfQuestionsIndex = 0
    @State private var answer = ""
    
    @State private var isPlaying = false
    @State private var showResult = false
    
    @State private var questions = [Question]()
    @State private var currentQuestionIndex = 0
    @State private var currentQuestion = Question(text: "", answer: 0)
    
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    
    let numberOfQuestions = [5, 10, 20]
    
    var body: some View {
        
        NavigationView {
            Form {
                if !showResult {
                    if !isPlaying {
                        Section {
                            Stepper(value: $maxMultiplicationTable, in: 1...10) {
                                Text("Até a tabuada do \(self.maxMultiplicationTable)")
                            }
                            
                            Picker("Quantas questões", selection: $numberOfQuestionsIndex) {
                                ForEach(0 ..< numberOfQuestions.count) {
                                    Text("\(self.numberOfQuestions[$0]) questões")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Button(action: playGame) {
                                Label("Começar jogo", systemImage: "gamecontroller")
                            }
                        }
                    } else {
                        Section(header: Text("Questão \(currentQuestionIndex + 1) de \(numberOfQuestions[numberOfQuestionsIndex])")) {
                            Text(currentQuestion.text)
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                        
                        Section {
                            TextField("Resposta", text: $answer)
                                .keyboardType(.decimalPad)
                            Button(action: sendAnswer) {
                                Text("Responder")
                            }
                        }
                    }
                }
                    
                if showResult {
                    Section(header: Text("Resultado")) {
                        Label("\(correctAnswers) Acertos", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        
                        Label("\(wrongAnswers) Erros", systemImage: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    Section {
                        Button(action: restartGame) {
                            Label("Jogar novamente", systemImage: "gamecontroller")
                        }
                    }
                }
            }
            .navigationBarTitle("Jogo da Tabuada")
        }
    }
    
    func playGame() {
        var question: Question
        var x: Int
        var y: Int
        
        questions = [Question]()
        
        for _ in 0...numberOfQuestions[numberOfQuestionsIndex] {
            
            x = Int.random(in: 1...10)
            y = Int.random(in: 1...maxMultiplicationTable)
            
            question = Question(text: "\(x) x \(y)", answer: (x*y))
            questions.append(question)
        }
        
        currentQuestionIndex = 0
        currentQuestion = questions[currentQuestionIndex]
        
        isPlaying = true
    }
    
    func sendAnswer() {
        let numberAnswer = Int(answer) ?? 0
        
        if numberAnswer == currentQuestion.answer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex < numberOfQuestions[numberOfQuestionsIndex] {
            currentQuestion = questions[currentQuestionIndex]
        } else {
            isPlaying = false
            showResult = true
        }
        
        answer = ""
    }
    
    func restartGame() {
        isPlaying = false
        showResult = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
