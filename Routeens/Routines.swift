//
//  Routines.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation

class Routines: ObservableObject {
   @Published var routine = [Routine]()
   
   init(){
//	  self.routines = routines
	  //I just want to load up the app with some tasks and routines without any data entry
	  var morningTasks = [Task]()
	  morningTasks.append(Task(name:"Brush teeth"))
	  morningTasks.append(Task(name:"Make bed"))
	  morningTasks.append(Task(name:"Take out trash"))
	  morningTasks.append(Task(name:"Put backpack in car"))
  
	  let morningRoutine = Routine(tasks: morningTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 9, endTimeMinute: 0)
	  self.routine.append(morningRoutine)
//		 var routines = [Routine]()
//		 routines.append(morningRoutine)
	 //	  Routines(routines: routines)
		 
	  
   }
   
   
}
