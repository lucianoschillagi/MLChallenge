//
//  MercadoPagoClient.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Networking */

import Foundation
import Alamofire

/* Abstract:
Una clase que encapsula los métodos para realizar las solicitudes web (API Calls).
*/

class MercadoPagoClient: NSObject {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// crea un singleton
	static let sharedInstance = MercadoPagoClient()
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	override init() {
		super.init()
	}
	
	//*****************************************************************
	// MARK: - API Calls Methods
	//*****************************************************************
	
	// task: realiza una solicitud web para obtener los métodos de pago disponibles (tarjetas de crédito disponibles)
	static func getPayMethods(_ completionHandlerForCreditCardsObject: @escaping ( _ success: Bool, _ creditCards: [CreditCard]?, _  errorString: String?) -> Void) {
		
		
		// first callback
		// https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88
		
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme
		components.host = MercadoPagoClient.Constants.ApiHost
		components.path = MercadoPagoClient.Constants.ApiPath
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
		components.queryItems!.append(queryItem1)

		// first callback 🚀8"]
		//Alamofire.request("\(MercadoPagoClient.Constants.FirstCallUrl)") .responseJSON { response in
		Alamofire.request(components.url!).responseJSON { response in

			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "error with response status: \(status)"
				}
			}

			// si se obtuvo el JSON exitosamente
			if let jsonObjectResult = response.result.value {
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				let resultsCreditCards = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				completionHandlerForCreditCardsObject(true, resultsCreditCards, nil)

			} // end if-let

		} // end closure
		
	}
	
	// task: realiza una solicitud web para obtener los BANCOS asociados a la tarjeta de crédito seleccionada por el usuario
	static func getCardIssues(_ completionHandlerForCardIssuesObject: @escaping ( _ success: Bool, _ cardIssues: [Bank]?, _  errorString: String?) -> Void) {
		
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme
		components.host = MercadoPagoClient.Constants.ApiHost
		components.path = MercadoPagoClient.Constants.ApiPath
		
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
		let queryItem2 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PaymentMethod, value: MercadoPagoClient.ParameterValues.PaymentMethod)
		components.queryItems!.append(queryItem1)
		components.queryItems!.append(queryItem2)
		
		// TODO: acá es necesario pasarle la tarjeta de crédito elegida por el usuario 👈
		Alamofire.request(components.url!) .responseJSON { response in
			debugPrint("url para obtener los bancos \(components.url!)")
			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "error with response status: \(status)"
				}
			}
			
			// si se obtuvo el JSON exitosamente
			if let jsonObjectResult = response.result.value {
				debugPrint("lo ultimo \(jsonObjectResult)")
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				//let resultBanks = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				let resultBanks = Bank.banksFromResults(jsonObjectResult as! [[String : AnyObject]])
				print("ESTO\(resultBanks)")
				
				
				for bank in resultBanks {
					
					
				}
	
				completionHandlerForCardIssuesObject(true, resultBanks, nil)
				
			} // end if-let
			
		} // end closure
		
	}
	
	// task: realiza una solicitud web para obtener el 'recommend_message', objeto necesario para extraer los datos a mostrar en el 'alert view' de la pantalla inicial
//	static func getRecommendMessage(_ completionHandlerForRecommendMessageObject: @escaping ( _ success: Bool, _ recommendMessage: [String:AnyObject]?, _  errorString: String?) -> Void) {
//		
//		var components = URLComponents()
//		components.scheme = MercadoPagoClient.Constants.ApiScheme
//		components.host = MercadoPagoClient.Constants.ApiHost
//		components.path = MercadoPagoClient.Constants.ApiPath
//		
//		components.queryItems = [URLQueryItem]()
//		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
//		let queryItem2 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.Amount, value: MercadoPagoClient.ParameterValues.Amount)
//		let queryItem3 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PaymentMethod, value: MercadoPagoClient.ParameterValues.PaymentMethod)
//		let queryItem4 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.IssuerId, value: MercadoPagoClient.ParameterValues.IssuerId)
//
//		components.queryItems!.append(queryItem1)
//		components.queryItems!.append(queryItem2)
//		components.queryItems!.append(queryItem3)
//		components.queryItems!.append(queryItem4)
//		
//		// TODO:
//		Alamofire.request(components.url!) .responseJSON { response in
//			
//			// check response status code
//			if let status = response.response?.statusCode {
//				switch(status){
//				case 200:
//					print("👏example success")
//				default:
//					let errorMessage = "error with response status: \(status)"
//				}
//			}
//			
//			// si se obtuvo el JSON exitosamente
//			if let jsonObjectResult = response.result.value {
//				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
//				//let resultBanks = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
//				let resultBanks = RecommendMessage.recommend(jsonObjectResult as! [[String : AnyObject]])
//				completionHandlerForRecommendMessageObject(true, resultBanks, nil)
//				
//			} // end if-let
//			
//		} // end closure
//		
//		
//		
//	
//	}
	
	
	// task: realiza una solicitud web donde envía la URL de la imagen y obtiene los datos de la misma
	static func taskForGETImage(_ thumbPath: String,completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) {
	
		
		//1.
		Alamofire.request(thumbPath) .responseData { response in
			
			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "🏋🏻‍♂️error with response status: \(status)"
				}
			}
			
			debugPrint("📦\(response)")
			
			// si se obtuvo el JSON exitosamente
			if let thumbDataResponse = response.result.value {
				debugPrint("XXX \(thumbDataResponse)")
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				//let resultsCreditCards = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				completionHandlerForImage(thumbDataResponse , nil)
				
			} // end if-let
			
		} // end closure
	}
	

	
	
	//*****************************************************************
	// MARK: - Create URLs
	//*****************************************************************
	
	//https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
	
	// create a URL from parameters
//	func mercadoPagoURLFromParameters(_ parameters: [String:AnyObject]) -> URLConvertible {
//		
//		var components = URLComponents()
//		components.scheme = MercadoPagoClient.Constants.ApiScheme // 'https'
//		components.host = MercadoPagoClient.Constants.ApiScheme // 'api.mercadopago.com'
//		components.path = MercadoPagoClient.Constants.ApiPath
//		components.queryItems = [URLQueryItem]()
//		
//		for (key, value) in parameters {
//			let queryItem = URLQueryItem(name: key, value: "\(value)")
//			components.queryItems!.append(queryItem)
//		}
//		
//		return components.url!
//	}
	
}
