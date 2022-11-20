//
//  Routine.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation

struct Routine: Identifiable, Codable  {
   var id = UUID()
   let routineName: String
   var tasks = [Task]()
   var startTime: Date
   var startTimeHour: Int
   var startTimeMinutes: Int
   var endTime: Date
   var endTimeHour: Int
   var endTimeMinutes: Int
   var lastOpened: Date
   
   init (routineName: String, tasks: [Task], startTimeHour: Int, startTimeMin: Int, endTimeHour: Int, endTimeMinute: Int){
	  self.routineName = routineName
	  self.tasks = tasks
	  self.startTimeHour = startTimeHour
	  self.startTimeMinutes = startTimeMin
	  self.endTimeHour = endTimeHour
	  self.endTimeMinutes = endTimeMinute
	  
	  var startTimeComponents = DateComponents()
	  startTimeComponents.hour = startTimeHour
	  startTimeComponents.minute = startTimeMin
	  self.startTime = Calendar.current.date(from: startTimeComponents) ?? Date.now
	  
	  var endTimeComponents = DateComponents()
	  endTimeComponents.hour = endTimeHour
	  endTimeComponents.minute = endTimeMinute
	  self.endTime = Calendar.current.date(from: endTimeComponents) ?? Date.now
	  
	  self.lastOpened = Date.now
   }
   
   
}
