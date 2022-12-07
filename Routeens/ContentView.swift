//
//  ContentView.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
   @StateObject var routineManager = RoutineManager()
   @State var textColor: Color = Color.black
   @State private var showingUtilities = false
   @State private var confetti:Int = 0

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
				RoutineManagerView(routineManager: routineManager)
			 } label: {
				Text("Routine Manager").padding()
			 }
		  }
		  .navigationTitle("Routeens")
		  .onAppear{
			 routineManager.loadActiveRoutines()
			 routineManager.userNotifications()
		  }
		  .toolbar {
			 Button {
				showingUtilities = true
			 } label: {
				Image(systemName: "gearshape.fill")
			 }
		  }
		  .alert("Congratulations!", isPresented: $routineManager.tasksComplete, actions: {
		  }, message: {Text("You completed a routine!")})
		  .confettiCannon(
			counter: $routineManager.confetti,
			num: 100,
			rainHeight: 1000,
			radius: 400
		  )
		  .sheet(isPresented: $showingUtilities) {
			 UtilitiesView(routineManager: routineManager)
		  }
	   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


