//
//  AddTrainingView.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import SwiftUI
import RealmSwift

struct AddTrainingView: View {
    
    @State private var isShowingChoseExerciseView = false

    var body: some View {
        
        ZStack{
            NavigationView {
                Form {
                    
                    Button {
                        isShowingChoseExerciseView = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    
                    .sheet(isPresented: $isShowingChoseExerciseView) {
                                // Present ChoseExerciseView when the sheet is active
                                ChoseExerciseView()
                            }
                }
               
                
                .navigationBarTitle("Add Training")
                .background(Color("CustomGray"))
                .scrollContentBackground(.hidden)
            }
        }
        
    }
}


#Preview {
    AddTrainingView()
}
