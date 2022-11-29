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
				Text("Add a New Routine").foregroundColor(.gray)
				NavigationLink(destination: EditRoutineView(routine: routineManager.allRoutines.last ?? Routine(routineName: "", tasks: [], startTime: Date(), endTime: Date())), isActive: $isShowingAddRoutineView){ EmptyView() }
				Button (""){
				   routineManager.createNewRoutine()
				   routineManager.save()
				   isShowingAddRoutineView = true
				} //label: {
//				   Image(systemName: "plus.circle.fill")
//								   .foregroundColor(.green)
//								   .padding(.leading, 0)
//								   .font(.system(size: 18))
//				}
				.foregroundColor(.gray)
			 }
		  }
		  .navigationTitle("Routine Manager")
		  .navigationBarTitleDisplayMode(.inline)
//   	  .background(.darkBackground)
		  
		  
		  
//		  NavigationLink(destination: EditRoutineView(routine: routineManager.allRoutines.last ?? Routine(routineName: "", tasks: [], startTime: Date(), endTime: Date())), isActive: $isShowingAddRoutineView){ EmptyView() }
//		  Button("Add a Routine") {
//			 routineManager.createNewRoutine()
//			 routineManager.save()
//			 isShowingAddRoutineView = true
//		  }
		  .padding()
		  .onAppear(perform: routineManager.loadActiveRoutines)
	   } header: {
			Text("These are all the routines.  Add a new one, make changes, or delete.")
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

