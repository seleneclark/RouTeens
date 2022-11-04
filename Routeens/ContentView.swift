//
//  ContentView.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import SwiftUI


struct ContentView: View {
   @StateObject var routines = Routines()

   
    var body: some View {
	   NavigationView {
		  List{
			 ForEach(routines.routine) { routine in
				
//				Text(routine.startTime , format: .dateTime.hour().minute())
//				Text(routine.endTime , format: .dateTime.hour().minute())
				let start = Calendar.current.dateComponents([.hour, .minute], from: routine.startTime)
				let end = Calendar.current.dateComponents([.hour, .minute], from: routine.endTime)
				let now = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
				if (start < now && now < end ){
				   Text("We are inside the timeframe")
				   ForEach (routine.tasks){ task in
					  HStack {
						 task.visible ? Text(task.name) : Text(task.name).foregroundColor(.gray)
					  }
				   }
				} else {
				   Text("Freedom!!! There are no routines to do🎉")
				}
				
				
				
			 }
		  }
		  .navigationTitle("Routeens")
	   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension DateComponents: Comparable {
	public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
		let now = Date()
		let calendar = Calendar.current
		return calendar.date(byAdding: lhs, to: now)! < calendar.date(byAdding: rhs, to: now)!
	}
}
