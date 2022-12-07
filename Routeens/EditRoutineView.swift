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
				HStack{
				   TextField("New task", text: $newTaskName)
				   Button {
					  let task = Task(name: newTaskName, pending: true)
					  routine.tasks.append(task)
					  routine.objectWillChange.send()
					  newTaskName = ""
				   } label: {
					  Image(systemName: "plus.circle.fill")
									  .foregroundColor(.green)
									  .padding(.leading, 0)
									  .font(.system(size: 18))
		 		   }
			    }
			 }
		  }header: {
	   			 Text("Tasks")
		  }
	   }

	   .navigationTitle("Edit Routine")
	   .navigationBarTitleDisplayMode(.inline)
    }
   func removeItems(at offsets: IndexSet){
	  routine.tasks.remove(atOffsets: offsets)
	  routine.objectWillChange.send()
   }
}

//struct RoutineEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//	   RoutineEditorView(routine: Routine())
////		  .preferredColorScheme(.dark)
//    }
//}
