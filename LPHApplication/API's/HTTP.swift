//
//  HTTP.swift
//  LPHApplication
//
//  Created by Tom Murray on 06/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation

class HTTP {
	
	//Proprties
	lazy var session: URLSession = {
		var sesh = URLSession.shared
		return sesh
	}()
	var dataTask: URLSessionDataTask?
	let headers = [
		"X-SIGNAGELIVE-WBI-APP-ID": "6538d918-fc17-47d6-9394-605d115a95ec",
		"X-SIGNAGELIVE-WBI-APP-KEY": "2d7fe491-b147-4062-90e6-402d59438373",
		"Content-Type":"application/json",
		]
	
	func createRequest(for group: PlayerGroupName, with interrupt: Interrupt) -> URLRequest {
		//fetches the compatible url information
		let group = group.playerGroupIdentifier
		let interrupt = interrupt.interruptToSend
//		let additionalData = [["Key": "theatre", "value": String("\(group)")], ["Key": "time", "Value": "0"], ["Key": "action", "Value": "0"]]
		let parameters = ["interrupt" : interrupt, "groups": [], "players" : [57599], "aditionalData" : []] as [String : AnyObject]
		let urlString = "https://wbtapi.signagelive.com/networks/15479/messages/"
		let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
		var request = URLRequest(url: (URL(string: urlString)!))
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = headers
		request.httpBody = postData
		print(parameters)
		return request
	}
	
	func sendRequest(url: URLRequest, completion: @escaping (Bool, Int) -> ()) {
		dataTask?.cancel()
		dataTask = session.dataTask(with: url) { (data, response, error) in
			guard let response = response as? HTTPURLResponse else {
				print("failed response")
				return}
			let success = self.checkResonse(responseCode: response.statusCode)
			DispatchQueue.main.async {
				completion(success, response.statusCode)
			}
		}
		dataTask?.resume()
	}
	
	//cancel any currently running tasks
	func cancelTask() {
		if dataTask != nil {
			dataTask?.cancel()
		}
	}
	
	func checkResonse(responseCode: Int) -> Bool {
		var result = false
		switch(responseCode) {
		case 200, 201:
			result = true
		case 204, 400, 401, 403, 404, 405, 408, 409, 500, 501, 503:
			result = false
		default:
			break
		}
		return result
	}
}
