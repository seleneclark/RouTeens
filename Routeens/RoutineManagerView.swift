//
//  RoutinesView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutineManagerView: View {
   @ObservedObject var routineManager: RoutineManager
   @State private var isShowingAddRoutineView = false
   
    var body: some View {
	   
	   Section {
		  List{
			 ForEach(routineManager.allRoutines) { routine in
				NavigationLink{
				   EditRoutineView(routine: routine)
				} label: {
				   Text(routine.routineName)
				}
			 }
			 .onDelete(perform: removeItems)
			 HStack{
				Text("Add Routine").foregroundColor(.gray)
				NavigationLink(destination: EditRoutineView(routine: routineManager.allRoutines.last ?? Routine(routineName: "", tasks: [], startTime: Date(), endTime: Date())), isActive: $isShowingAddRoutineView){ EmptyView() }
				Button (""){
				   routineManager.createNewRoutine()
				   routineManager.save()
				   isShowingAddRoutineView = true
				}
				.foregroundColor(.gray)
			 }
		  }
		  .navigationTitle("Routine Manager")
		  .navigationBarTitleDisplayMode(.inline)
		  .padding()
		  .onAppear(perform: routineManager.loadActiveRoutines)
	   } header: {
			Text("Add a new routine, make changes, or delete.")
			 .padding()
			 .foregroundColor(.gray)
	   }
    }
   func removeItems(at offsets: IndexSet){
	  routineManager.allRoutines.remove(atOffsets: offsets)
	  routineManager.save()
   }
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
	   RoutineManagerView(routineManager: RoutineManager())
    }
}

