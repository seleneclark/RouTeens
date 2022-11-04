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
   let startTime: Date?
   let endTime: Date?
   
   init (routineName: String, tasks: [Task], startTimeHour: Int, startTimeMin: Int, endTimeHour: Int, endTimeMinute: Int){
	  self.routineName = routineName
	  self.tasks = tasks
	  
	  var startTimeComponents = DateComponents()
	  startTimeComponents.timeZone = TimeZone(abbreviation: "MST")
	  startTimeComponents.hour = startTimeHour
	  startTimeComponents.minute = startTimeMin
	  let userCalendar = Calendar(identifier: .gregorian)
	  self.startTime = userCalendar.date(from: startTimeComponents)
	  
	  var endTimeComponents = DateComponents()
	  endTimeComponents.timeZone = TimeZone(abbreviation: "MST")
	  endTimeComponents.hour = endTimeHour
	  endTimeComponents.minute = endTimeMinute
	  self.endTime = userCalendar.date(from: endTimeComponents)
   }
   
   
}
