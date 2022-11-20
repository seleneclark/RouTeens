//
//  ContentView.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import SwiftUI

struct ContentView: View {
   @StateObject var routineManager = RoutineManager()
   @State var textColor: Color = Color.black

    var body: some View {
	   NavigationView {
		  VStack {
			List{
				ForEach(routineManager.routines) { routine in
				   ForEach (routine.tasks){ task in
					  Button(task.name, action: {
						 routineManager.togglePending(with: routine, task: task)
					  }).foregroundColor((task.pending) ? .black : .gray)
				   }
				}
				if routineManager.noPendingTasks {Text("You have no tasks").bold()}
			 }
			 Spacer()
			 NavigationLink{
				RoutinesView(routineManager: routineManager)
			 } label: {
				Text("Routine Manager")
			 }
		  }
		  .navigationTitle("Routeens")
		  .onAppear(perform: routineManager.loadActiveRoutines)
//		  .onDisappear(perform: routines.removeRoutines)
	   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


