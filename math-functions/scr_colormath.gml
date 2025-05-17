#macro hex_letters ["A" , "B" , "C" , "D" , "E" , "F"]
#macro hex_numbers {"A": 10 , "B": 11 , "C": 12 , "D": 13 , "E": 14 , "F": 15}

function rgb_to_hex(R , G , B){
	if !is_numeric(R) || !is_numeric(G) || !is_numeric(B) {
	return
	}
	
	R = min(255 , max(0 , R))
	G = min(255 , max(0 , G))
	B = min(255 , max(0 , B))
	
	var hex = {r: "" , b: "" , g: ""}
	
	while R > 0 || B > 0 || G > 0 {
		//Red
		if R%16 > 9 {
			hex.r = string_concat(hex.r , hex_letters[(R%16)-10])
			
		}else{
			hex.r = string_concat(hex.r , string(R%16))
		}
		
		R = floor(R/16)
		//Blue
		if B%16 > 9 {
			hex.b = string_concat(hex.b , hex_letters[(B%16)-10])
			
		}else{
			hex.b = string_concat(hex.b , string(B%16))
		}
		
		B = floor(B/16)
		//Green
		if G%16 > 9 {
			hex.g = string_concat(hex.g , hex_letters[(G%16)-10])
		}else{
			hex.g = string_concat(hex.g , string(G%16))
		}
		
		G = floor(G/16)
		
	}
	//sorry there was an inconsistency lmao
	hex = string_concat(string_concat("0x" , string(hex.b)) , string_concat(string(hex.r) , string(hex.g)))
	
	
	return hex
}


//hex to rgb
function hex_to_rgb(hex_string){
	if !is_string(hex_string) {
	hex_string = string(hex_string)
	}
	
	hex_string = string_delete(hex_string , 0 , 2)
	
	var rgb = {
		r: string_delete(hex_string , 3 , 4) ,
		g: string_delete(hex_string , 0 , 4),
		b: string_delete(string_delete(hex_string , 0 , 2) , 3 , 2)
		}
	
	var i = 0
	var payload = []
	//Red
		repeat string_length(rgb.r) {
			
			payload[i] = string_delete(rgb.r , i - 1 , 1)
			if struct_get(hex_numbers , payload[i]) != undefined {
				
				payload[i] = string(struct_get(hex_numbers , payload[i]))
				
			}
			
			i++
		}
		
		payload = [real(payload[1]) , real(payload[0])]
		
		
		rgb.r = (payload[0]*16) + payload[1]
		
		payload = []
		i = 0
		
		//Green
		repeat string_length(rgb.g) {
			
			payload[i] = string_delete(rgb.g , i - 1 , 1)
			if struct_get(hex_numbers , payload[i]) != undefined {
				
				payload[i] = string(struct_get(hex_numbers , payload[i]))
				
			}
			
			i++
		}
		
		payload = [real(payload[1]) , real(payload[0])]
		
		
		rgb.g = (payload[0]*16) + payload[1]
		
		payload = []
		i = 0
		
		//Blue
		repeat string_length(rgb.b) {
			
			payload[i] = string_delete(rgb.b , i - 1 , 1)
			if struct_get(hex_numbers , payload[i]) != undefined {
				
				payload[i] = string(struct_get(hex_numbers , payload[i]))
				
			}
			
			i++
		}
		
		payload = [real(payload[1]) , real(payload[0])]
		
		
		rgb.b = (payload[0]*16) + payload[1]
		
		payload = []
		i = 0
		
	return rgb
}
