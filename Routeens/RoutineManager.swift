//
//  Routines.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation
import SwiftUI
import UserNotifications

struct Preferences: Codable {
   var savedRoutines:[Routine]
   var areNotificationsOn:Bool
}


class RoutineManager: ObservableObject {
   @Published var routines = [Routine]()
   @Published var noPendingTasks = true
   @Published var allRoutines = [Routine]()
   @Published var tasksComplete:Bool = false
   @Published var confetti:Int = 0
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
	  let currentDate = Date.now
	  if (currentDate > routine.lastOpened){
		 let currentDate = Date.now
		 let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
		 let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: routine.endTime)
		 var newDateComponents = DateComponents()
		 newDateComponents.year = dateComponents.year
		 newDateComponents.month = dateComponents.month
		 newDateComponents.day = dateComponents.day
		 newDateComponents.hour = endTimeComponents.hour
		 newDateComponents.minute = endTimeComponents.minute
		 routine.lastOpened = Calendar.current.date(from: newDateComponents) ?? Date.now
		 
		 for i in routine.tasks.indices {
			routine.tasks[i].pending = true
		 }
	  }
   }
   
   func togglePending(with routine: Routine, task: Task) {
	  var checkTasksComplete = true
	  for rIndex in allRoutines.indices {
		 if (allRoutines[rIndex].routineName == routine.routineName) {
			for tIndex in allRoutines[rIndex].tasks.indices {
			   if (allRoutines[rIndex].tasks[tIndex].name == task.name) {
				  allRoutines[rIndex].tasks[tIndex].pending.toggle()
			   }
			   //if there is even 1 task that is still pending, tasksComplete is false
			   if (allRoutines[rIndex].tasks[tIndex].pending == true){
				  checkTasksComplete = false
			   }
			}
		 }
	  }
	  // When all the tasks are complete, set these published variables to
	  // trigger the alert and confetti in ContentView
	  if (checkTasksComplete == true){
		 tasksComplete = true
		 confetti += 1
		 print("congratulations")
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

	  let preferences = Preferences(savedRoutines: allRoutines, areNotificationsOn: notificationState )
	  if let encoded = try? JSONEncoder().encode(preferences) {
		 UserDefaults.standard.set(encoded, forKey: "SavedData")
	  }
//	  if let encoded = try? JSONEncoder().encode(allRoutines) {
//		 UserDefaults.standard.set(encoded, forKey: "BackupData")
//	  }
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
	  // Prep to save/initialize notifications
	  if let data = UserDefaults.standard.data(forKey: "SavedData"){
		 if let decoded = try? JSONDecoder().decode(Preferences.self, from: data){
			allRoutines = decoded.savedRoutines
			notificationState = decoded.areNotificationsOn
			return
		 }
	  }
   }
}

extension DateComponents: Comparable {
	public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
		let now = Date()
		let calendar = Calendar.current
		return calendar.date(byAdding: lhs, to: now)! < calendar.date(byAdding: rhs, to: now)!
	}
}
