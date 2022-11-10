//
//  Routines.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation
import SwiftUI

class Routines: ObservableObject {
   @Published var routine = [Routine]()
   @Published var noPendingTasks = true
   
   var allRoutines = [Routine]()

   
   func loadActiveRoutines(){
	  // reset pending if current date is after the end of the routine lastOpened date is
	  resetPendingTasks()
	  
	  allRoutines.forEach { singleroutine in
		 //maybe put reset pending here, since I'm already going thru each routine
		 
		 let start = Calendar.current.dateComponents([.hour, .minute], from: singleroutine.startTime)
		 let end = Calendar.current.dateComponents([.hour, .minute], from: singleroutine.endTime)
		 let now = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
		 if (start < now && now < end) {
			self.routine.append(singleroutine)
			noPendingTasks = false
		 }
		 
	  }
	  
   }
   
   func resetPendingTasks(){
	  // First implement Saving (because I won't be able to test if it works without save)
	  // I need to reset the pending tasks IF we have moved out of the active routine
	  // probably need a Date() for the last time it was used and then compare it to the endtime??
   }
   
   init(){
	  //I just want to load up the app with some tasks and routines without any data entry
	  var morningTasks = [Task]()
	  morningTasks.append(Task(name:"Brush teeth", pending: true))
	  morningTasks.append(Task(name:"Make bed", pending: true))
	  morningTasks.append(Task(name:"Take out trash", pending: false))
	  morningTasks.append(Task(name:"Put backpack in car", pending: true))
  
	  let morningRoutine = Routine(routineName: "Morning Routine", tasks: morningTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 12, endTimeMinute: 0)
	  self.allRoutines.append(morningRoutine)
	  var afternoonTasks = [Task]()
	  afternoonTasks.append(Task(name:"Eat lunch", pending: true))
	  afternoonTasks.append(Task(name:"Walk dog", pending: true))
	  afternoonTasks.append(Task(name:"Empty Dishwasher", pending: false))
  
	  let afternoonRoutine = Routine(routineName: "Afternoon Routine", tasks: afternoonTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 23, endTimeMinute: 0)
	  self.allRoutines.append(afternoonRoutine)
   }
}
extension DateComponents: Comparable {
	public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
		let now = Date()
		let calendar = Calendar.current
		return calendar.date(byAdding: lhs, to: now)! < calendar.date(byAdding: rhs, to: now)!
	}
}
