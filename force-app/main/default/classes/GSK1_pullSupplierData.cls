public with sharing class GSK1_pullSupplierData {
    public static void pullDatas() {
        String SAP_Ariba_Url = 'https://openapi.ariba.com/api/supplierdatapagination/v4/sandbox/vendorDataRequests?realm=gsk-T&$count=true&$skip=100&$top=50';
        Map<STring, String> headerMap = new Map<String, String>();
        try {
            Datetime currentDateTime = System.today();
            Datetime prevDayDateTime = currentDateTime.addHours(12) - 1;
            String modifiedCurrentDate = changeDateFormat(currentDateTime);
            String modifiedprevDayDateTime = changeDateFormat(prevDayDateTime);
            String callBodyy ='{'+
            '    "smVendorIds": ['+
            '       "S123456",'+
            '       "S234567"'+
            '    ],'+
            '    "businessUnitList": ['+
            '       "408",'+
            '       "1000"'+
            '    ],'+
            '    "categoryList": ['+
            '       "51",'+
            '       "71"'+
            '    ],'+
            '    "outputFormat": "JSON",'+
            '    "preferredLevelList": ['+
            '       0,'+
            '       2,'+
            '       4,'+
            '       5'+
            '    ],'+
            '    "qualificationStatusList": ['+
            '       "Qualified",'+
            '       "QualificationStarted",'+
            '       "InQualification"'+
            '    ],'+
            '    "regionList": ['+
            '       "USA",'+
            '       "INDIA"'+
            '    ],'+
            '    "registrationStatusList": ['+
            '       "Registered",'+
            '       "InRegistration"'+
            '    ],'+
            '    "withQuestionnaire": true,'+
            '    "withGenericCustomFields": true'+
            ' }' ;
            SAP_Ariba_Url = SAP_Ariba_Url+'$'+'filter=updatedDateFrom ge '+modifiedprevDayDateTime+' and updatedDateTo le '+modifiedCurrentDate;
            String accessToken = GSK1_AribaGetAccessTokenService.getSupplierAccessToken();
            System.debug('accessToken :: '+accessToken);
             //This will return exception message in case of system not able to get the access token
             /* if(accessToken.startswith('Error'))
                 //return 'Error&&' + accessToken */
            HttpRequest req = new HttpRequest();
            HttpResponse resp = new HttpResponse();
            Http http = new Http();
            req.setEndPoint('https://eu.openapi.ariba.com/api/supplierdatapagination/v4/prod/vendorDataRequests?realm=gsk-S-T&$filter=updatedDateFrom ge 2022-08-14T05:11:00Z and updatedDateTo le 2022-08-29T14:11:00Z&$count=true&$skip=1000');
             req.setHeader('Authorization', 'Bearer ' + accessToken);
             req.setHeader('apiKey', 'rRPTQM38UTbILMygU5dQKFmHgnoiU6PO'); // old -> kC4kR39T84KGYcXitpOMyJU1Tzwyy5Gf
             req.setTimeout(120000);
             req.setMethod('POST');
             //req.setHeader('Content-Type', 'application/json');
             req.setBody('{'+
    '"outputFormat": "JSON"'+
'}');
             /* resp = */ http.send(req);
             System.debug('Ariba Create CW API Response Status Code=> ' +  resp.getStatusCode());
             System.debug('Ariba Create CW API Response Body => ' + resp.getBody());
             string respbody=resp.getBody();
             Blob txtBlob = Blob.valueOf(respbody); //Convert it to a blob
             if (resp.getStatusCode() == 200 || resp.getStatusCode() == 201 ) {
                List<String> SuppListToUpdate = new List<String>();
                              System.debug('Ariba Create CW API Response Body => ' + resp.getBody());
                //JSON2GetAribaCWId resp1 =  JSON2GetAribaCWId.parse(respbody);
                //for(JSON2GetAribaCWId.Value res : resp1.value){
                  //  SuppListToUpdate.add(res.supplier.name);
                //}
                List<Account> AccountListToUpdate = new List<Account>();
                try {
                    AccountListToUpdate = [Select Id, Name From Account WHERE Name IN:SuppListToUpdate];
                } catch(Exception e) {
                    System.debug(e.getMessage());
                }
                //System.debug('response=>'+respbody);

             }else{
                System.debug('response=>'+respbody);

             }
             /* Attachment attach = new Attachment(); //Make an attachment
             attach.Name ='text.Json';  
             attach.Body = txtBlob;
             attach.ContentType= 'application/xml'; //Signal what the file's MIME type is
             attach.ParentID = 'a0G8L000000501zUAA';
             insert attach; */
        } catch(Exception e) {
            System.debug(e.getMessage());
            
        }
    }

    public static String changeDateFormat(Datetime datee){
       
        system.debug('ag**'+datee);
        //String DateStr = String.valueOf(datee.date());
        String DateStr = datee.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        //String timeStr = String.valueOf(datee.time());
        system.debug('ag**'+DateStr);

        //system.debug('ag**'+timeStr);
        //DateStr = DateStr+'T';
        //timeStr = timeStr+'Z';
        return DateStr;
    }
}