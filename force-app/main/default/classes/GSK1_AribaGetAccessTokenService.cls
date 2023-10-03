/**  
 * @Description        : Ariba API Service to get the access token from SAP Ariba
 * @Author             : Ankit Verma
 * @Date               : 31-08-2022 (DD-MM-YYYY)
 * @TestClass          : NA
*/
public class GSK1_AribaGetAccessTokenService {
    /* Description : Making callout to SAP Ariba to get access token
	 * Params      : None
	 * Return      : access token
	 */
    public static String getAccessToken() {
        String accessToken = null;
//Supplier
        try {
            Http http = new Http();        
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GSK_Legacy');
            request.setMethod('POST');
            String username = 'troy.x.halverson@gsk.com.sit';
            String password = 'Conga2022##';
        
            Blob headerValue = Blob.valueOf(username + ':' + password);
            
            request.setHeader('apiKey', 'd2i5WRfgPMEMK09V2nLyu6J5mH7A6Ngz');
            //request.setHeader(key, kC4kR39T84KGYcXitpOMyJU1Tzwyy5Gf);
            HttpResponse response = http.send(request);
            system.debug('response=>'+response.getBody());
            accessToken = GSK1_AribaGetAccessTokenService.extractAccessToken(response.getBody());
            System.debug(accessToken);
        } catch (Exception ex) {
            accessToken = 'Error: Exception in Ariba Authorization. Message: ' + ex.getMessage() + ', LineNo: ' + ex.getLineNumber();
            System.debug(accessToken);
        }
        
        return accessToken;
    }
    
    public static String getSupplierAccessToken() {
        String accessToken = null;
//Supplier
        try {
            Http http = new Http();        
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:Supplier');
            request.setMethod('POST');            
            request.setHeader('apiKey', 'rRPTQM38UTbILMygU5dQKFmHgnoiU6PO');
            //request.setHeader(key, kC4kR39T84KGYcXitpOMyJU1Tzwyy5Gf);
            HttpResponse response = http.send(request);
            system.debug('response=>'+response.getBody());
            accessToken = GSK1_AribaGetAccessTokenService.extractAccessToken(response.getBody());
            System.debug(accessToken);
        } catch (Exception ex) {
            accessToken = 'Error: Exception in Ariba Authorization. Message: ' + ex.getMessage() + ', LineNo: ' + ex.getLineNumber();
            System.debug(accessToken);
        }
        
        return accessToken;
    }


    /* Description : This method is used to build Http Request with method type, endpoint, headers and request body
     * Params      : String methodType, String endpoint, Map<String, String> headersMap, String requestBody
     * Return      : HttpRequest
     */
    public static HTTPRequest buildHttpRequest(String methodType, String endpoint, Map<String, String> headersMap, String requestBody) {
        HTTPRequest request = new HTTPRequest();
        request.setMethod(methodType); 
        request.setEndpoint(endpoint);
        request.setTimeout(120000);        
        for (String key : headersMap.keySet()) {
            request.setHeader(key, headersMap.get(key));
        }
        if(String.isNotBlank(requestBody))
        	request.setBody(requestBody);
        
        return request;
    }
	
    /* Description : This method is used to get the access token from the response 
     * Params      : String responseBody
     * Rerurn      : access token
     */
    Private static String extractAccessToken(String responseBody) {
		Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(responseBody);
        return (String)responseMap.get('access_token');
    }
}