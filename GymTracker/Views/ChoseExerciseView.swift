//
//  ChoseExerciseView.swift
//  TESCIK
//
//  Created by Kuba on 20/12/2023.
//

import SwiftUI
import FirebaseStorage

struct ChoseExerciseView: View {
    
    
    @StateObject private var viewModel = ChooseExerciseViewModel()
    @State private var selectedExercise: Exercise?
    @State private var sets: Int = 1
    @State private var repetitions: Int = 0
    @State private var weight: Double? = nil
    @State private var exerciseSets: [SetsModel] = []
    @State private var showingAlert = false
    @State private var exerciseToSetsMap: [Exercise: [SetsModel]] = [:]
    @State private var dateOfTraining = Date()
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingExerciseSelection = false
    
    var body: some View {
        
        ZStack{
            NavigationView {
                Form {
                    Button(action: {
                        isShowingExerciseSelection = true
                    }) {
                        Text(selectedExercise?.name ?? "Select Exercise")
                            .foregroundColor(selectedExercise == nil ? .blue : .white)
                    }
                    
                    .sheet(isPresented: $isShowingExerciseSelection) {
                        ExerciseSelectionView(selectedExercise: $selectedExercise, availableExercises: availableExercises)
                    }
                    
                    Section(header: Text("Exercise Details")) {
                        
                        Text("Set: \(sets)")
                        
                        
                        Stepper(value: $repetitions, in: 0...20, label: {
                            Text("Repetitions: \(repetitions)")
                        })
                        
                        HStack{
                            Text("Weight: ")
                            TextField("Kg", value: $weight, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                        }
                        
                    }
                    
                    
                    Section() {
                        List {
                            ForEach(Array(exerciseToSetsMap.keys), id: \.self) { exercise in
                                Section(header: Text(exercise.name)) {
                                    ForEach(exerciseToSetsMap[exercise] ?? [], id: \.self) { set in
                                        Text("Set: \(set.sets), Repetitions: \(set.repetitions), Weight: \(set.weight) kg")
                                    }
                                    .foregroundColor(.white)
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    
                    Section {
                        Button("Add Set") {
                            let newSet = SetsModel(sets: sets, repetitions: repetitions, weight: weight ?? 0)
                            if let selected = selectedExercise {
                                exerciseToSetsMap[selected, default: []].append(newSet)
                                sets = 1 + (exerciseToSetsMap[selected]?.count ?? 0)
                                weight = nil
                                exerciseSets = exerciseToSetsMap[selected] ?? []
                                print(exerciseToSetsMap)
                            } else {
                                showingAlert = true
                            }
                            
                        }
                        
                        Button("Save Training") {
                            viewModel.saveTraining(with: exerciseToSetsMap) { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success():
                                        exerciseToSetsMap.removeAll()
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    case .failure(let error):
                                        print("Error saving training session: \(error)")
                                    }
                                }
                            }
                        }
                        
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Select exercise"),
                                message: Text("Please select your ecercise."))
                        }
                        
                    }
                    
                }
                
                
                
                .navigationBarTitle("Add Training")
                .background(Color("CustomGray"))
                .scrollContentBackground(.hidden)
            }
            .onChange(of: selectedExercise) { newExercise in
                if let newExercise = newExercise {
                    // Load sets for the newly selected exercise
                    repetitions = 0
                    exerciseSets = exerciseToSetsMap[newExercise] ?? []
                    sets = 1 + (exerciseToSetsMap[newExercise]?.count ?? 0)
                }
            }
            
        }
    }
}





#Preview {
    ChoseExerciseView()
}


