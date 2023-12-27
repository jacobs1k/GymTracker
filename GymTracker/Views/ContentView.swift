//
//  ContentView.swift
//  TESCIK
//
//  Created by Kuba on 03/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Profil"

    var body: some View {
        
        
        NavigationView {
                TabView(selection: $selectedTab) {
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag("Profil")
                    
                    HistoryView()
                        .tabItem {
                            Image(systemName: "clock")
                            Text("History")
                        }
                        .tag("Historia")                    
                    AddTrainingView()
                        .tabItem {
                            Image(systemName: "plus")
                            Text("Add Training")
                            
                        }
                        .tag("Dodaj Trening")
                    
                    ExercisesView()
                        .tabItem {
                            Image(systemName: "dumbbell")
                            Text("Exercises")
                        }
                        .tag("Ćwiczenia")
                    
                    MoreView()
                        .tabItem {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.blue)
                            Text("More")
                                .background(Color("CustomGray"))
                        }
                        .tag("Więcej")
                }
            
                .navigationBarHidden(false)
                
            }
        }
        
}

#Preview {
    ContentView()
}
