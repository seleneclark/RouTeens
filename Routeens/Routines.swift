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
	  allRoutines.forEach { singleroutine in
		 let start = Calendar.current.dateComponents([.hour, .minute], from: singleroutine.startTime)
		 let end = Calendar.current.dateComponents([.hour, .minute], from: singleroutine.endTime)
		 let now = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
		 if (start < now && now < end) {
			self.routine.append(singleroutine)
			noPendingTasks = false
		 }
	  }
   }
   
   init(){
	  //I just want to load up the app with some tasks and routines without any data entry
	  var morningTasks = [Task]()
	  morningTasks.append(Task(name:"Brush teeth", visible: true))
	  morningTasks.append(Task(name:"Make bed", visible: true))
	  morningTasks.append(Task(name:"Take out trash", visible: false))
	  morningTasks.append(Task(name:"Put backpack in car", visible: true))
  
	  let morningRoutine = Routine(routineName: "Morning Routine", tasks: morningTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 12, endTimeMinute: 0)
	  self.allRoutines.append(morningRoutine)
	  var afternoonTasks = [Task]()
	  afternoonTasks.append(Task(name:"Eat lunch", visible: true))
	  afternoonTasks.append(Task(name:"Walk dog", visible: true))
	  afternoonTasks.append(Task(name:"Empty Dishwasher", visible: false))
  
	  let afternoonRoutine = Routine(routineName: "Afternoon Routine", tasks: afternoonTasks, startTimeHour: 13, startTimeMin: 0, endTimeHour: 14, endTimeMinute: 0)
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