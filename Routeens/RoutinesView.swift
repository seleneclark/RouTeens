//
//  RoutinesView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutinesView: View {
   @ObservedObject var routineManager: RoutineManager
   
    var body: some View {
	   VStack {
		  Text("Routine Manager")
		  List{
			 ForEach(routineManager.allRoutines) { routine in
				NavigationLink{
				   RoutineEditorView(routine: routine)
				} label: {
				   Text(routine.routineName)
				}
			 }
		  }
//		  NavigationLink{
//			 RoutineEditorView(routineManager: routineManager, routine: Routine(routineName: "", tasks: [], startTime: Date(), endTime: Date()))
//		  } label: {
//			 Text("Add a Routine")
//		  }
	   }
    }
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
	   RoutinesView(routineManager: RoutineManager())
    }
}
