//
//  ExerciseSelectionView.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @Binding var selectedExercise: Exercise?
    let availableExercises: [Exercise]
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        List(availableExercises, id: \.self) { exercise in
            HStack {
                FirebaseImageView(imageName: exercise.imageName)
                    .frame(width: 50, height: 50)
                Text(exercise.name)
                Spacer()
                if exercise == selectedExercise {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedExercise = exercise
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitle("Select Exercise")
    }
}

//#Preview {
//    ExerciseSelectionView()
//}
