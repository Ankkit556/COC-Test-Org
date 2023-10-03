//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*  @author    - 
    @className - UpdateObligationsResponseByEmail
    @TestClass - UpdateObligationsResponseByEmailTest
    @Working   - Handle the Incoming Obligation Emails. */
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
global with sharing class UpdateObligationsResponseByEmail implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = email.BinaryAttachments;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        Account obli = new  Account();
        String emailBody = '';  //Holds the Body of email
        String emailSubject = '';   //Holds the Id of Obligation
        try {
            emailBody = email.plainTextBody;
            emailSubject = email.subject;
            if(emailSubject != ''){
                System.debug('emailSubject'+ emailSubject);
                obli = [SELECT Id , Name FROM Account WHERE Id =:emailSubject WITH SECURITY_ENFORCED]; 
            }
            if(binaryAttachments !=Null){
                List<ContentVersion> doc = new List<ContentVersion>();
                Set<Id> docIds = new Set<Id>();
                /*Setting File Version and other important configs  */
                for(Messaging.Inboundemail.BinaryAttachment bAttachment : binaryAttachments){
                    System.debug('binaryAttachments->'+ bAttachment);
                    ContentVersion idoc = new ContentVersion();
                    idoc.Title = bAttachment.fileName;
                    idoc.ContentLocation = 'S';
                    idoc.PathOnClient = bAttachment.fileName;
                    idoc.VersionData = bAttachment.body;
                    doc.add(idoc); 
                    
                }
                if(doc.size()>0){
                    Database.insert(doc);
                    for(ContentVersion cv : doc){
                        docIds.add(cv.Id);
                        System.debug('hbvyvvu=>'+cv.Id);
                    }
                    List<ContentVersion> cdList = new List<ContentVersion>();
                 
                    cdList = [SELECT Id, PathOnClient, Title, ContentDocumentId FROM CONTENTVERSION WHERE Id IN:docIds with SECURITY_ENFORCED];
                   /*Creating Link Between File and Record */
                    List<ContentDocumentLink> contentDocumentLinkInstance = new List<ContentDocumentLink>();
                    if(!cdList.isEmpty()){
                        ContentDocumentLink icd;
                        for(ContentVersion cv:cdList){
                            icd = new ContentDocumentLink();
                            icd.ContentDocumentId = cv.ContentDocumentId;
                            icd.linkedEntityId = emailSubject;
                            icd.sharetype = 'I';
                            icd.visibility = 'AllUsers';
                            contentDocumentLinkInstance.add(icd);
                        }
                    }
                    if(!contentDocumentLinkInstance.isEmpty()){
                        Database.insert(contentDocumentLinkInstance);
                    }
                }
                
            }
            /* Here we will update Obligations */
        } catch (Exception e) {
            System.debug('e=>'+e);
        }
        result.success = true;
        return result;
    }
}