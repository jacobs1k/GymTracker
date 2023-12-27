//
//  ProfileView.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedExercise: Exercise?
    @State private var isShowingExerciseSelection = false
    
    var body: some View {
        ZStack{
            Color("CustomGray")
                            .ignoresSafeArea()
            VStack {
                            Button(action: {
                                isShowingExerciseSelection = true
                            }) {
                                Text(selectedExercise?.name ?? "Select Exercise")
                                    .foregroundColor(selectedExercise == nil ? .blue : .white)
                            }
                            .padding()
                
                            ProgressChartView(viewModel: viewModel, selectedExercise: $selectedExercise)
                        }
                    }
                    .sheet(isPresented: $isShowingExerciseSelection) {
                        ExerciseSelectionView(selectedExercise: $selectedExercise, availableExercises: availableExercises)
        }
    }
}

#Preview {
    ProfileView()
}
