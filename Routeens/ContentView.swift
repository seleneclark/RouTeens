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
   @State private var showingUtilities = false

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
		  .onAppear(perform: routineManager.loadActiveRoutines)
		  .toolbar {
			 Button {
				showingUtilities = true
			 } label: {
				Image(systemName: "gear")
			 }
		  }
		  .sheet(isPresented: $showingUtilities) {
			 UtilitiesView()
		  }
		  
		  
	   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


