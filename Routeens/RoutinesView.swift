//
//  RoutinesView.swift
//  Routeens
//
//  Created by Selene on 11/17/22.
//

import SwiftUI

struct RoutinesView: View {
   @StateObject var allRoutines = Routines()
   
    var body: some View {
	   VStack {
		  Text("This is where you can add, edit or delete Routines")
		  List{
			 ForEach(allRoutines.allRoutines) { routine in
				NavigationLink{
				   RoutineEditorView(routine: routine)
				} label: {
				   Text(routine.routineName)
				}
			 }
		  }
	   }
    }
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
	   RoutinesView()
    }
}
