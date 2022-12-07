//
//  Utilities.swift
//  Routeens
//
//  Created by Selene on 11/28/22.
//

import SwiftUI
import UserNotifications

struct UtilitiesView: View {
   @ObservedObject var routineManager: RoutineManager
   @Environment(\.dismiss) var dismiss

    var body: some View {
	   NavigationView {
		  VStack {
			 Toggle(isOn: $routineManager.notificationState, label: {
				Text("Notifications allowed")
			 }).padding()
				.onChange(of: routineManager.notificationState){ value in
			   print(value)
			   if (value == true) {
				  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					  if success {
						  print("All set!")
					  } else if let error = error {
						  print(error.localizedDescription)
						  routineManager.notificationState = false
					  }
				  }
			   } else {
				  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
			   }
			}
			Spacer()
		  }
		  .navigationTitle("Notifications")
		  .navigationBarTitleDisplayMode(.inline)
		  .toolbar {
			 Button("Done"){
				dismiss()
			 }
		  }
	   }
    }
}

struct Utilities_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesView(routineManager: RoutineManager())
    }
}
