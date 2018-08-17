//
//  Installments.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 08/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/*
Abstract: Un objeto que almacena los datos recibidos por el JSON 'Installments' para luego usarlos en la construcción del ´alert view´ a mostrar como fin del proceso en la pantalla inicial.
*/

struct Installments {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// propiedades preparadas para recibir, mapear y almacenar los valores deseados:

	// contiene información acerca del pago del usuario
	// un array de diccionarios que tiene SÓLO 1 miembro
	let payerCosts: [[String:AnyObject]]?
	
	
	/* PAYER COSTS OBJECT ---------------------------------------------
	[
					{
					"payment_method_id": "visa",
					"payment_type_id": "credit_card",
					"issuer": {
												"id": "288",
												"name": "Tarjeta Shopping",
												"secure_thumbnail": "https://www.mercadopago.com/org-img/MP3/API/logos/288.gif",
												"thumbnail": "http://img.mlstatic.com/org-img/MP3/API/logos/288.gif"
												},
					"processing_mode": "aggregator",
					"merchant_account_id": null,
					"payer_costs": [ <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	
												{
												"installments": 1, <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_rate": 0,
												"discount_rate": 0,
												"labels": [
												"CFT_0,00%|TEA_0,00%"
												],
												"installment_rate_collector": [
												"MERCADOPAGO"
												],
												"min_allowed_amount": 0,
												"max_allowed_amount": 250000,
												"recommended_message": "1 cuota de $ 30,00 ($ 30,00)", <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_amount": 30,
												"total_amount": 30 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												},
	
	
												{
												"installments": 3, <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_rate": 13.92,
												"discount_rate": 0,
												"labels": [
												"CFT_120,42%|TEA_93,32%"
												],
												"installment_rate_collector": [
												"MERCADOPAGO"
												],
												"min_allowed_amount": 2,
												"max_allowed_amount": 250000,
												"recommended_message": "3 cuotas de $ 11,39 ($ 34,17)", <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_amount": 11.39,
												"total_amount": 34.17 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												},
	
	
												{
												"installments": 6, <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_rate": 26.62,
												"discount_rate": 0,
												"labels": [
												"CFT_130,09%|TEA_101,12%",
												"recommended_interest_installment_with_some_banks"
												],
												"installment_rate_collector": [
												"MERCADOPAGO"
												],
												"min_allowed_amount": 3,
												"max_allowed_amount": 250000,
												"recommended_message": "6 cuotas de $ 6,33 ($ 37,98)", <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_amount": 6.33,
												"total_amount": 37.98 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												},
	
	
												{
												"installments": 9, <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_rate": 39.93,
												"discount_rate": 0,
												"labels": [
												"CFT_133,02%|TEA_103,92%"
												],
												"installment_rate_collector": [
												"MERCADOPAGO"
												],
												"min_allowed_amount": 5,
												"max_allowed_amount": 250000,
												"recommended_message": "9 cuotas de $ 4,66 ($ 41,97)", <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_amount": 4.66,
												"total_amount": 41.97 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												},
	
	
												{
												"installments": 12, <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_rate": 53.24,
												"discount_rate": 0,
												"labels": [
												"recommended_installment",
												"CFT_132,06%|TEA_103,75%"
												],
												"installment_rate_collector": [
												"MERCADOPAGO"
												],
												"min_allowed_amount": 6,
												"max_allowed_amount": 250000,
												"recommended_message": "12 cuotas de $ 3,83 ($ 45,97)", <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												"installment_amount": 3.83,
												"total_amount": 45.97 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
												}
									]
					}
	]

	END PAYER COSTS OBJECT ---------------------------------------------  */

	// la cantidad de cuotas
	var installments: Int = 0
	
	// un mensaje que contiene información acerca del monto según la cantidad de cuotas
	var recommendMessage: String = " "
	
	// el total a pagar con la recarga de las cuotas
	var totalAmount: Double = 0
	
	
	// un array que contiene los diversos 'installments' disponibles
	static var installmentsArray: [Int] = []

	// un array que contiene los diversos 'recommendMessage' disponibles
	static var recommendMessageArray: [String] = []
	
	// un array que contiene los diversos 'totalAmount' disponibles
	static var totalAmountArray: [Double] = []
	
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir un objeto Foundation (Dictionary<String:AnyObject>) 'Installments' desde el JSON obtenido.
	
	// inicializa la struct con un diccionario como parámetro requerido
	init(dictionary: [String:AnyObject]) {
	
		// extrae el valor al que apunta la clave "payer_costs", en este caso un array de diccionarios ('Array<[String:AnyObject]>')
		payerCosts = dictionary["payer_costs"] as! [[String:AnyObject]]

		
		// comprueba si la clave "payer_costs" contiene algún valor
		if let payerCostsDictionary = payerCosts {
		
			// si es contiene algún valor, entonces iterar el array de diccionario
			// para extraer mediante las claves los valores deseados de los 5 objetos que contiene el array
			for item in payerCostsDictionary {
				
				installments = item["installments"] as! Int
				recommendMessage = item["recommended_message"] as! String
				totalAmount = item["total_amount"] as! Double

				debugPrint("los 5 installments son: \(installments)")
				debugPrint("los 5 recommend message son: \(recommendMessage)")
				debugPrint("los 5 total amount son: \(totalAmount)")
				
				// TODO: almacenar en correspondientes arrays los valores iterados de:
				// installments, recommendMessage, totalAmount
					Installments.installmentsArray.append(installments)
					Installments.recommendMessageArray.append(recommendMessage)
					Installments.totalAmountArray.append(totalAmount)
			
			}
			
			debugPrint("los 5 installments almancenados en el array, LISTOS PARA USAR son: \(Installments.installmentsArray)")
//			debugPrint("los 5 recommend message almancenados en el array, LISTOS PARA USAR son: \(Installments.recommendMessageArray)")
//			debugPrint("los 5 total amount almancenados en el array, LISTOS PARA USAR son: \(Installments.totalAmountArray)")
//
//			debugPrint("este es el 2do elemento de 'recommendMessageArray' : \(Installments.recommendMessageArray[1])")
			
		}
		
	}
	
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	/**
	task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'Installments'
	
	- parameter installmentsObjectResult: el Json obtenido convertido a un array de diccionarios Foundation.
	- returns: un array de objetos 'Installments' con sus propiedades ya rellenadas con los valores buscados. (ATENCIÓN: este array contiene sólo 1 elemento)
	*/
	
	static func installmentsFromResults(_ installmentsObjectResult: [[String:AnyObject]]) -> [Installments] {
		
		// un array de 'Installments' listo para ser rellenado con los valores solicitados
		var installmentsArray = [Installments]()

		// itera el array de diccionarios, cada 'Installments' es un diccionario
		for installments in installmentsObjectResult {
			installmentsArray.append(Installments(dictionary: installments))
		}

		// un array de objetos 'Installments' con los valores correpondientes obtenidos y almacenados
		return installmentsArray
		
		
	}
	
	
} // end struct
