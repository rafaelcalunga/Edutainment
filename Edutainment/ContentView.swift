//
//  ContentView.swift
//  Edutainment
//
//  Created by Rafael Calunga on 2020-09-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var total = 1
    @State private var numberOfQuestions = 0
    @State private var answer = ""
    
    @State private var isPlaying = true
    @State private var showResult = true
    
    let quantityOfQuestions = [5, 10, 20]
    
    var body: some View {
        
        NavigationView {
            Form {
                //if !isPlaying {
                    Section {
                        Stepper(value: $total, in: 1...10) {
                            Text("Até a tabuada do \(self.total)")
                        }
                        
                        Picker("Quantas questões", selection: $numberOfQuestions) {
                            ForEach(0 ..< quantityOfQuestions.count) {
                                Text("\(self.quantityOfQuestions[$0]) questões")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section {
                        Button(action: {
                            // Do something
                        }) {
                            Label("Começar jogo", systemImage: "gamecontroller")
                        }
                    }
                //} else {
                    Section(header: Text("Questão 1 de 5")) {
                        Text("1 x 2")
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    }
                    
                    Section {
                        TextField("Resposta", text: $answer)
                            .keyboardType(.decimalPad)
                        Button(action: {
                            // Do something
                        }) {
                            Text("OK")
                        }
                    }
                //}
                
                //if showResult {
                    Section(header: Text("Resultado")) {
                        Label("12 Acertos", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        
                        Label("0 Erros", systemImage: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    Section {
                        Button(action: {
                            // Do something
                        }) {
                            Label("Jogar novamente", systemImage: "gamecontroller")
                        }
                    }
                //}
            }
            .navigationBarTitle("Jogo da Tabuada")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
