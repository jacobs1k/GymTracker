//
//  ExercisesView.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import SwiftUI

struct ExercisesView: View {

    
    var body: some View {
        NavigationView{
            List(availableExercises, id: \.self) { exercise in
                HStack {
                    FirebaseImageView(imageName: exercise.imageName)
                        .frame(width: 50, height: 50)
                    Text(exercise.name)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .background(Color("CustomGray"))
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Exercises")
        }
    }
}

#Preview {
    ExercisesView()
}
