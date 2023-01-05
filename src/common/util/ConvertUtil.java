package common.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ConvertUtil {

	public static Map<String,String> ObjectToMap(Object object) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> map = objectMapper.convertValue(object, Map.class);
		
		return map;
	}
	
	public static HashMap<String, String> jsonToMap(String json) throws JsonParseException, JsonMappingException,ClassCastException , IOException {
	   	ObjectMapper objectMapper = new ObjectMapper();
	       TypeReference<HashMap<String, Object>> typeReference = new TypeReference<HashMap<String, Object>>() { };
	       HashMap<String, Object> object = objectMapper.readValue(json, typeReference);
	       HashMap<String,String> newMap =new HashMap<String,String>();
	   	for (Map.Entry<String, Object> entry : object.entrySet()) {
		       if(entry.getValue() instanceof String){
		            newMap.put(entry.getKey(), (String) entry.getValue());
		          }
	   	}
	   	return newMap;        
	}
	
	
}
