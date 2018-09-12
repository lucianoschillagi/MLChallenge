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
	
	// 1st callback  //////////////////////////////////////////////
	
	// task: realiza una solicitud web para obtener los métodos de pago disponibles (tarjetas de crédito disponibles)
	static func getPayMethods(_ completionHandlerForCreditCardsObject: @escaping ( _ success: Bool, _ creditCards: [CreditCard]?, _  errorString: String?) -> Void) {
		
		// https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88
		
		/* 1-Create URL ✒️ */
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme
		components.host = MercadoPagoClient.Constants.ApiHost
		components.path = MercadoPagoClient.Constants.ApiPath_PaymentMethods
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
		components.queryItems!.append(queryItem1)
		
		/* 2-Request 🚀 */
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
			
			/* 3-Response 📦 */
			// comprueba si se obtuvieron los objetos json (un array de objetos json)
			if let creditCard_JSONObject = response.result.value {
				
				// test
				debugPrint("Estos son los objetos JSON recibidos. Cada objeto representa una tarjeta de crédito distinta. \(creditCard_JSONObject).")
				
				// usa los datos obtenidos en el Json para rellenar (mapeando) las propiedades del objeto 'CreditCard' !!!!!!!!!!!!!!!!!!!!! 👈👈👈
				let resultsCreditCards = CreditCard.creditCardsFromResults(creditCard_JSONObject as! [[String : AnyObject]])
				
				// test
				debugPrint("Este es el objeto JSON obtenido que representa a la tarjetas de crédito convertido a un array de diccionarios Foundation LISTOS PARA USAR \(resultsCreditCards).")
				
				// completa el completion handler con los valores deseados ya listos para usar
				completionHandlerForCreditCardsObject(true, resultsCreditCards, nil)

			} // end if-let

		} // end closure
		
	} // end func
	
	
	// 2nd callback 🚀 //////////////////////////////////////////////
	
	// task: realiza una solicitud web para obtener los BANCOS asociados a la tarjeta de crédito seleccionada por el usuario
	static func getCardIssues(_ completionHandlerForCardIssuesObject: @escaping ( _ success: Bool, _ cardIssues: [Bank]?, _  errorString: String?) -> Void) {
		
		// https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=visa
		
		/* 1-Create URL ✒️ */
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme
		components.host = MercadoPagoClient.Constants.ApiHost
		components.path = MercadoPagoClient.Constants.ApiPath_CardIssues
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
		let queryItem2 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PaymentMethod, value: MercadoPagoClient.ParameterValues.PaymentMethod)
		components.queryItems!.append(queryItem1)
		components.queryItems!.append(queryItem2)
		
		
		/* 2-Request 🚀 */
		Alamofire.request(components.url!) .responseJSON { response in
			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					debugPrint("status code \(status)")
					print("👏example success")
				default:
					let errorMessage = "🥁error with response status: \(status)"
				}
			}
			
			/* 3-Response 📦 */
			// comprueba si se obtuvieron los objetos json (un array de objetos json)
			if let bank_JSONObject = response.result.value {
				
				// test
				debugPrint("Estos son los objetos JSON recibidos. Cada objeto representa un banco distinto. \(bank_JSONObject).")
				
				// usa los datos obtenidos en el Json para rellenar (mapeando) las propiedades del objeto 'Bank !!!!!!!!!!!!!!!!!!!!! 👈👈👈
				let resultBanks = Bank.banksFromResults(bank_JSONObject as! [[String:AnyObject]])

				// test
				debugPrint("Este es el objeto JSON obtenido que representa a los bancos convertido a un array de diccionarios Foundation LISTOS PARA USAR \(resultBanks).")
				
				// completa el completion handler con los valores deseados ya listos para usar
				completionHandlerForCardIssuesObject(true, resultBanks, nil)
				
			} // end if-let
			
		} // end closure
		
	} // end func
	
	// 3rd callback 🚀 //////////////////////////////////////////////
	
	// task: realiza una solicitud web para obtener el 'recommend_message'
	static func getRecommendMessage(_ completionHandlerForRecommendMessageObject: @escaping ( _ success: Bool, _ recommendMessage: [Installments]?, _  errorString: String?) -> Void) {
		
			//https://api.themoviedb.org/3/movie/upcoming?api_key=0942529e191d0558f888245403b4dca7&language=en-US&page=1

		/* 1-Create URL ✒️ */
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme
		components.host = MercadoPagoClient.Constants.ApiHost
		components.path = MercadoPagoClient.Constants.ApiPath_Installments
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PublicKey, value: MercadoPagoClient.ParameterValues.PublicKey)
		let queryItem2 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.Amount, value: MercadoPagoClient.ParameterValues.Amount)
		let queryItem3 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.PaymentMethod, value: MercadoPagoClient.ParameterValues.PaymentMethod)
		let queryItem4 = URLQueryItem(name: MercadoPagoClient.ParameterKeys.IssuerId, value: MercadoPagoClient.ParameterValues.IssuerId)
		components.queryItems!.append(queryItem1)
		components.queryItems!.append(queryItem2)
		components.queryItems!.append(queryItem3)
		components.queryItems!.append(queryItem4)
		
		/* 2-Request 🚀 */
		Alamofire.request(components.url!) .responseJSON { response in

			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "error with response status: \(status)"
				}
			}

			/* 3-Response 📦 */
			// comprueba si se obtuvieron los objetos json (un array de objetos json)
			if let installments_JSONObject = response.result.value {
				
				// test
				debugPrint("Estos son los objetos JSON recibidos. Cada objeto (en realidad es sólo 1), contiene datos para calcular el valor de cada cuota, etc \(installments_JSONObject).")
				
				// usa los datos obtenidos en el Json para rellenar (mapeando) las propiedades del objeto 'Installments' !!!!!!!!!!!!!!!!!!!!! 👈👈👈
				let resultsInstallments = Installments.installmentsFromResults(installments_JSONObject as! [[String: AnyObject]])
				
				// test
				debugPrint("😆Este es el objeto JSON obtenido que representa a las cuotas convertido a un array de diccionarios Foundation LISTOS PARA USAR \(resultsInstallments).")

				// completa el completion handler con los valores deseados ya listos para usar
				completionHandlerForRecommendMessageObject(true, resultsInstallments, nil)

			} // end if-let

		} // end closure

	} // end func
	
	
	// task: realizar una solicitud web donde envía la URL de la imagen y obtiene los datos de la misma
	static func taskForGETImage(_ thumbPath: String,completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) {

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
				completionHandlerForImage(thumbDataResponse , nil)
				
			} // end if-let
			
		} // end closure
	
	} // end func
	


} // end class
