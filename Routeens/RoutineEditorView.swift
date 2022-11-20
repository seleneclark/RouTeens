//
//  RoutineEditorView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutineEditorView: View {
//   @ObservedObject var routineManager: RoutineManager
   @ObservedObject var routine: Routine
   
   
    var body: some View {
	   NavigationView {
		  Form {
			 Text("Edit Routine")
			 TextField("Routine Name:", text: $routine.routineName)
			 DatePicker("Start Time: ", selection: $routine.startTime, displayedComponents: .hourAndMinute)
			 DatePicker("End Time: ", selection: $routine.endTime, displayedComponents: .hourAndMinute)
		  }
	   }
	   .navigationTitle("Routine Manager")
	   .navigationBarTitleDisplayMode(.inline)
	   
//	   .background(.darkBackground)
	   
    }
}

//struct RoutineEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//	   RoutineEditorView(routine: Routine())
////		  .preferredColorScheme(.dark)
//    }
//}
