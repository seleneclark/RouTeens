//
//  RoutinesView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutinesView: View {
   @ObservedObject var routineManager: RoutineManager
   @State private var isShowingAddRoutineView = false
   
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
		  NavigationLink(destination: RoutineEditorView(routine: routineManager.allRoutines.last ?? Routine(routineName: "", tasks: [], startTime: Date(), endTime: Date())), isActive: $isShowingAddRoutineView){ EmptyView() }
		  Button("Add a Routine") {
			 routineManager.createNewRoutine()
			 routineManager.save()
			 isShowingAddRoutineView = true
		  }
	   }
	   
    }
   
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
	   RoutinesView(routineManager: RoutineManager())
    }
}

