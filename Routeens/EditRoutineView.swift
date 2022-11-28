//
//  RoutineEditorView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct EditRoutineView: View {
   @ObservedObject var routine: Routine
   @State private var newTaskName: String = ""
   
    var body: some View {
	   Form {
		  Section {
			 TextField("Routine Name:", text: $routine.routineName)
			 DatePicker("Start Time: ", selection: $routine.startTime, displayedComponents: .hourAndMinute)
			 DatePicker("End Time: ", selection: $routine.endTime, displayedComponents: .hourAndMinute)
		  }header: {
			 Text("Current Routine")
	  }
		  Section {
			 List{
				ForEach(routine.tasks){ task in
				   Text(task.name)
				}
				.onDelete(perform: removeItems)
				TextField("New task", text: $newTaskName)
			 }
//			 .listStyle(.insetGrouped)
		  }header: {
	   			 Text("Tasks")
		  }
	   }

	   .navigationTitle("Edit Routine")
	   .navigationBarTitleDisplayMode(.inline)
//   //	   .background(.darkBackground)
	   Button("Add a Task") {
		  let task = Task(name: newTaskName, pending: true)
		  routine.tasks.append(task)
	   }
    }
   func removeItems(at offsets: IndexSet){
	  routine.tasks.remove(atOffsets: offsets)
//	  routineManager.save()
   }
}

//struct RoutineEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//	   RoutineEditorView(routine: Routine())
////		  .preferredColorScheme(.dark)
//    }
//}
