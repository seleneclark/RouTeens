//
//  RoutineEditorView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutineEditorView: View {
   @State var routine: Routine
    var body: some View {
	   NavigationView {
		  Form {
			 Text("Routine Name: " + routine.routineName)
			 DatePicker("Start Time: ", selection: $routine.startTime, displayedComponents: .hourAndMinute)
			 DatePicker("End Time: ", selection: $routine.endTime, displayedComponents: .hourAndMinute)

//   		  TextField("Start Time", text: $routine.startTimeHour)
   //		  Text(routine.startTimeMinutes)
   //		  Text(routine.endTimeHour)
   //		  Text(routine.endTimeMinutes)
		  }
		  
		  
	   }
	   .navigationTitle("Routine Manager")
	   .navigationBarTitleDisplayMode(.inline)
//	   .background(.darkBackground)
	   
    }
}

//struct RoutineEditorView_Previews: PreviewProvider {
//   var allRoutines = Routines()
//    static var previews: some View {
//	   RoutineEditorView(routine: allRoutines[0])
////		  .preferredColorScheme(.dark)
//    }
//}
