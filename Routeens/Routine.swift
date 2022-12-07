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
   var endTime: Date
   var lastOpened: Date
   
   init (routineName: String, tasks: [Task], startTime: Date, endTime: Date){
	  self.routineName = routineName
	  self.tasks = tasks
	  self.startTime = startTime
	  self.endTime = endTime
	  self.lastOpened = Date.now
   }
}
