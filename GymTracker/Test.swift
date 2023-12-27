import SwiftUI
import RealmSwift

// ViewModel to interact with the Realm database
class WorkoutViewModel: ObservableObject {
    private var realm: Realm
    
    init() {
        // Initialize the Realm
        realm = try! Realm()
    }
    
    func addExerciseSet(name: String, whichBodyPart: String, sets: Int, repetitions: Int, weight: Double) {
        let exercise = Exercise(name: name, whichBodyPart: whichBodyPart)
        let setModel = SetsModel(sets: sets, repetitions: repetitions, weight: weight)
        
        // Begin write transaction
        try! realm.write {
            let exerciseSet = ExerciseSet()
            exerciseSet.exercise = exercise
            exerciseSet.sets.append(setModel)
            
            // If you want to create a new training session each time
            let training = Training()
            training.exercises.append(exerciseSet)
            training.date = Date()
            
            // Add the training session to the Realm
            realm.add(training)
        }
    }
}

struct AddExerciseView: View {
    @ObservedObject var viewModel = WorkoutViewModel()
    
    @State private var name: String = ""
    @State private var whichBodyPart: String = ""
    @State private var sets: Int = 0
    @State private var repetitions: Int = 0
    @State private var weight: Double = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Exercise Name", text: $name)
                    TextField("Targeted Body Part", text: $whichBodyPart)
                }
                
                Section(header: Text("Set Details")) {
                    Stepper("Sets: \(sets)", value: $sets, in: 1...10)
                    Stepper("Repetitions: \(repetitions)", value: $repetitions, in: 1...20)
                    HStack {
                        Text("Weight:")
                        Spacer()
                        TextField("Weight", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button(action: {
                    viewModel.addExerciseSet(name: name, whichBodyPart: whichBodyPart, sets: sets, repetitions: repetitions, weight: weight)
                    // Clear the fields after adding
                    name = ""
                    whichBodyPart = ""
                    sets = 0
                    repetitions = 0
                    weight = 0.0
                }) {
                    Text("Add Exercise Set")
                }
            }
            .navigationBarTitle("New Exercise Set", displayMode: .inline)
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView()
    }
}
