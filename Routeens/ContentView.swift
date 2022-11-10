//
//  ContentView.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import SwiftUI


struct ContentView: View {
   @StateObject var routines = Routines()
   @State var textColor: Color = Color.black

   
    var body: some View {
	   NavigationView {
			 List{
				ForEach($routines.routine) { $routine in
				   ForEach ($routine.tasks){ $task in
					  task.pending ? Button(task.name, action: {task.pending.toggle()}).foregroundColor(.black) : Button(task.name, action: {task.pending.toggle()}).foregroundColor(.gray)
				   }
				}
				if routines.noPendingTasks {Text("You have no tasks").bold()}
			 }
			 
		  .navigationTitle("Routeens")
		  .onAppear(perform: routines.loadActiveRoutines)
	   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


