//
//  Routine.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation

class Routine: Identifiable, Codable, ObservableObject  {
   var id = UUID()
   var routineName: String
   var tasks = [Task]()
   var startTime: Date
   var startTimeHour: Int
   var startTimeMinutes: Int
   var endTime: Date
   var endTimeHour: Int
   var endTimeMinutes: Int
   var lastOpened: Date
   
   init (routineName: String, tasks: [Task], startTime: Date, endTime: Date){
	  self.routineName = routineName
	  self.tasks = tasks
	  self.startTime = startTime
	  self.endTime = endTime
	  self.lastOpened = Date.now
	  
	  
	  // this part can be deleted once the add routine works
	  self.startTimeHour = 0
	  self.startTimeMinutes = 0
	  self.endTimeHour = 0
	  self.endTimeMinutes = 0
   }

   
   
   
//   init (routineName: String, tasks: [Task], startTimeHour: Int, startTimeMin: Int, endTimeHour: Int, endTimeMinute: Int){
//	  self.routineName = routineName
//	  self.tasks = tasks
//	  self.startTimeHour = startTimeHour
//	  self.startTimeMinutes = startTimeMin
//	  self.endTimeHour = endTimeHour
//	  self.endTimeMinutes = endTimeMinute
//
//	  var startTimeComponents = DateComponents()
//	  startTimeComponents.hour = startTimeHour
//	  startTimeComponents.minute = startTimeMin
//	  self.startTime = Calendar.current.date(from: startTimeComponents) ?? Date.now
//
//	  var endTimeComponents = DateComponents()
//	  endTimeComponents.hour = endTimeHour
//	  endTimeComponents.minute = endTimeMinute
//	  self.endTime = Calendar.current.date(from: endTimeComponents) ?? Date.now
//
//	  self.lastOpened = Date.now
//   }
   
}
