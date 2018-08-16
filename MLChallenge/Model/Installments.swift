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
	
	/*
	se buscan los valores de las claves:
	
	'payer_costs'
			'installments'
			'recommended_message'
*/
	
	// Recommend Message:
	
	// contiene información acerca del pago según la cantidad de cuotas elegidas por el usuario
	let payerCosts: [[String:AnyObject]]?
	
	// la cantidad de cuotas
	var installments: Int = 0
	
	// un mensaje que contiene información acerca del monto según la cantidad de cuotas
	var recommendMessage: String = " "
	
	// el total a pagar con la recarga de las cuotas
	var totalAmount: Double = 0

	
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir un objeto Foundation (Dictionary<String:AnyObject>) 'Installments' desde el JSON obtenido.
	
	// inicializa la struct con un diccionario como parámetro requerido)
	init(dictionary: [String:AnyObject]) {
		
		// payer costs
		// captura del Json obtenido el valor de la clave 'payer_costs' y la almancena en la propiedad 'payerCosts' del objeto 'Installments' 🔌
//		payerCosts = dictionary[MercadoPagoClient.Installments_JsonObject.JsonResponseKeys.PayerCosts] as! [String:AnyObject]
		
		payerCosts = dictionary["payer_costs"] as! [[String:AnyObject]]
		
		
		//installments = dictionary["installments"] as! Int
		
		// recommend message
		// captura del Json obtenido el valor de la clave 'recommended_message' y la almancena en la propiedad 'recommendMessage' del objeto 'Installments' 🔌
		//recommendMessage = dictionary["installments"] as! String
		
		// comprueba si 'payerCosts' contiene algún valor
		if let payerCostsDictionary = payerCosts {
			
			for item in payerCostsDictionary {
				installments = item["installments"] as! Int
				recommendMessage = item["recommended_message"] as! String
				totalAmount = item["total_amount"] as! Double
			}
			
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
