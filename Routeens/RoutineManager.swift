//
//  Routines.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation
import SwiftUI
import UserNotifications

class RoutineManager: ObservableObject {
   @Published var routines = [Routine]()
   @Published var noPendingTasks = true
   @Published var allRoutines = [Routine]()
   @Published var notificationState = false
   
   func loadActiveRoutines(){
	  self.routines = []
	  noPendingTasks = true
	  allRoutines.forEach { routine in
		 resetPendingTasks(with: routine)
		 let start = Calendar.current.dateComponents([.hour, .minute], from: routine.startTime)
		 let end = Calendar.current.dateComponents([.hour, .minute], from: routine.endTime)
		 let now = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
		 if (start < now && now < end) {
			self.routines.append(routine)
			noPendingTasks = false
		 }
	  }
	  save()
   }
   
   func resetPendingTasks(with routine: Routine){
	  // I need to reset the pending tasks IF we have moved out of the active routine
	  //1. check if (Date.now > routine.lastOpened)
	  //2.		{ set routine.lastOpened = current Date + routine.endTime }
	  //		this is set to today's date at the end of the routine
	  //		it should not reset the tasks if we are before the routine.endTime
	  //		but yes, reset if the current time is AFTER the lastOpened (routine.endTime)
	  //3. ALSO { go thru each task, and set pending to true }
   }
   
   func togglePending(with routine: Routine, task: Task) {
	  for rIndex in allRoutines.indices {
		 if (allRoutines[rIndex].routineName == routine.routineName) {
			for tIndex in allRoutines[rIndex].tasks.indices {
			   if (allRoutines[rIndex].tasks[tIndex].name == task.name) {
				  allRoutines[rIndex].tasks[tIndex].pending.toggle()
			   }
			}
		 }
	  }
	  save()
	  loadActiveRoutines()
   }
   
   func createNewRoutine() {
	  var startTimeComponents = DateComponents()
	  startTimeComponents.hour = 6
	  startTimeComponents.minute = 0
	  let startTime = Calendar.current.date(from: startTimeComponents) ?? Date.now
	  var endTimeComponents = DateComponents()
	  endTimeComponents.hour = 22
	  endTimeComponents.minute = 0
	  let endTime = Calendar.current.date(from: endTimeComponents) ?? Date.now
	  
	  let newRoutine = Routine(routineName: "New Routine", tasks: [], startTime: startTime, endTime: endTime)
	  allRoutines.append(newRoutine)
   }
   
   func save() {
	  // Prep to save/initialize notifications
//	  struct SaveTypes: Codable {
//		 var saveRoutines:[Routine]
//		 var saveNotification:Bool
//	  }
//	  let saveTypes = SaveTypes(saveRoutines: allRoutines, saveNotification: notificationState )
//	  if let encoded = try? JSONEncoder().encode(saveTypes) {
//		 UserDefaults.standard.set(encoded, forKey: "SavedData")
//	  }
	  if let encoded = try? JSONEncoder().encode(allRoutines) {
		 UserDefaults.standard.set(encoded, forKey: "SavedData")
	  }
   }
   
   func userNotifications(){
	  // Notifications are sent whenever a routine begins
	  let content = UNMutableNotificationContent()
	  allRoutines.forEach { routine in
		 content.title = "RouTeens"
		 content.subtitle = "Time for your " + routine.routineName
		 content.sound = UNNotificationSound.default
		 let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: routine.startTime)
		 let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		 UNUserNotificationCenter.current().add(request)
	  }
   }
   
   init(){
	  allRoutines = []
	  if let data = UserDefaults.standard.data(forKey: "SavedData"){
		 if let decoded = try? JSONDecoder().decode([Routine].self, from: data){
			allRoutines = decoded
			return
		 }
	  }
	  // Prep to save/initialize notifications
//	  if let data = UserDefaults.standard.data(forKey: "SavedData"){
//		 if let decoded = try? JSONDecoder().decode([Routine].self, from: data){
//			allRoutines = decoded
//			return
//		 }
//	  }
   }
}

extension DateComponents: Comparable {
	public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
		let now = Date()
		let calendar = Calendar.current
		return calendar.date(byAdding: lhs, to: now)! < calendar.date(byAdding: rhs, to: now)!
	}
}


//	  print("Task name: ",allRoutines[1].tasks[0].name)
//	  allRoutines[1].tasks[0].pending.toggle()
//	  print("Task pending value: ", task.pending)
//	  var tempRoutine = Routine(routineName: "", tasks: routine.tasks, startTimeHour: 0, startTimeMin: 0, endTimeHour: 0, endTimeMinute: 0)
	  
//	  print("Task name: ",tempRoutine.tasks[0].name)
//	  for i in tempRoutine.tasks.enumerated() {
//		 print(tempRoutine.tasks[i].name)
//	  }
//	  tempRoutine.tasks.forEach { tempTask in
//		 if (tempTask.name == task.name) {
//			tempTask.pending.toggle()
//		 }
//	  }
	  
	  
//	  let taskPending = !task.pending
//	  print(taskPending)
//	  _ = Task(id: task.id, name: task.name, pending: taskPending)
//	  print("Task pending changed: ", task.pending)


//I just want to load up the app with some tasks and routines without any data entry
//	  var morningTasks = [Task]()
//	  morningTasks.append(Task(name:"Brush teeth", pending: true))
//	  morningTasks.append(Task(name:"Make bed", pending: true))
//	  morningTasks.append(Task(name:"Take out trash", pending: false))
//	  morningTasks.append(Task(name:"Put backpack in car", pending: true))
//	  let morningRoutine = Routine(routineName: "Morning Routine", tasks: morningTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 23, endTimeMinute: 0)
//	  self.allRoutines.append(morningRoutine)
//	  var afternoonTasks = [Task]()
//	  afternoonTasks.append(Task(name:"Eat lunch", pending: true))
//	  afternoonTasks.append(Task(name:"Walk dog", pending: true))
//	  afternoonTasks.append(Task(name:"Empty Dishwasher", pending: false))
//	  let afternoonRoutine = Routine(routineName: "Afternoon Routine", tasks: afternoonTasks, startTimeHour: 6, startTimeMin: 0, endTimeHour: 23, endTimeMinute: 0)
//	  self.allRoutines.append(afternoonRoutine)


//toggle pending in the routines array - this will make it flip between grey and black
//	  for rIndex in routines.indices {
//		 if (routines[rIndex].routineName == routine.routineName) {
//			for tIndex in routines[rIndex].tasks.indices {
//			   if (routines[rIndex].tasks[tIndex].name == task.name) {
//				  routines[rIndex].tasks[tIndex].pending.toggle()
//				  print("Task pending value after toggle: ", routines[rIndex].tasks[tIndex].pending)
//			   }
//			}
//		 }
//	  }
