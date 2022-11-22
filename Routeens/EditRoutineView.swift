//
//  RoutineEditorView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct EditRoutineView: View {
   @ObservedObject var routine: Routine
   
    var body: some View {
	   Form {
		  TextField("Routine Name:", text: $routine.routineName)
		  DatePicker("Start Time: ", selection: $routine.startTime, displayedComponents: .hourAndMinute)
		  DatePicker("End Time: ", selection: $routine.endTime, displayedComponents: .hourAndMinute)
		  List{
			 Text("Tasks:").bold()
			 ForEach(routine.tasks){ task in
				Text(task.name)
			 }
			 .onDelete(perform: removeItems)
		  }
		  
		  //		  .padding()
	   }
	   .navigationTitle("Edit Routine")
	   .navigationBarTitleDisplayMode(.inline)
//   //	   .background(.darkBackground)
	   Button("Add a Task") {
//		  routineManager.createNewRoutine()
//		  routineManager.save()
//		  isShowingAddRoutineView = true
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
