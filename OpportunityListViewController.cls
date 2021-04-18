public with sharing class OpportunityListViewController {
    @AuraEnabled(cacheable = true)
    public static List<Opportunity> getOpportunityList(ID dealRecId){
        return [SELECT ID, Name, StageName, Plan_Number__c, Amount, Agency__c FROM Opportunity WHERE Deal__c =: dealRecId];
    }

    @AuraEnabled(cacheable = true)
    public static List<OpportunityLineItem> getOpptyList(ID dealRecId){
        /*Map<ID,List<Product2>> oppLineItemMap = new  Map<ID,List<Product2>>();
        for(OpportunityLineItem oli : [SELECT ID, Product2Id, Product2Id.Name, OpportunityId, Opportunity.Name, Opportunity.StageName, Opportunity.Plan_Number__c, Opportunity.Amount, Opportunity.Agency__c, 
                                        Opportunity.AE_Cross_Sell_Partner__c, Opportunity.StartDate__c, Opportunity.EndDate__c, Deal__c 
                                        FROM OpportunityLineItem 
                                        WHERE OpportunityId IN (SELECT ID FROM Opportunity WHERE Deal__c =: dealRecId)])
        {
            //oppLineItemMap.put(oli.Id, oli);
            if (oppLineItemMap.containsKey(oli.OpportunityId)) {
                List<Product2> prodsList = oppLineItemMap.get(oli.OpportunityId);
                prodsList.add(oli);
                oppLineItemMap.put(oli.OpportunityId, prodsList);
            } else {
                List<Product2> prodsList = new List<Product2>();
                prodsList.add(oli);
                oppLineItemMap.put(oli.OpportunityId, prodsList);
            }
        }
        System.debug('oppLineItemMap====='+oppLineItemMap);*/


        List<OpportunityLineItem> oliLst = new List<OpportunityLineItem>();
        oliLst = [SELECT ID, Product2Id, Product2.name, OpportunityId, Opportunity.Name, Opportunity.StageName, Opportunity.Plan_Number__c, Opportunity.Amount, Opportunity.Agency__r.Name, 
        Opportunity.AE_Cross_Sell_Partner__r.Name, Opportunity.StartDate__c, Opportunity.EndDate__c, Opportunity.Deal__c 
        FROM OpportunityLineItem
        WHERE OpportunityId IN (SELECT ID FROM Opportunity WHERE Deal__c =: dealRecId)];
        System.debug('oliLst====='+oliLst);

        return oliLst;

        
        /*return [SELECT Id,Name,StageName, Plan_Number__c, Amount, Agency__c, AE_Cross_Sell_Partner__c, StartDate__c, EndDate__c, Deal__c 
                FROM opportunity 
                WHERE Deal__c =: dealRecId];*/

        /*return [SELECT Id, Name 
                FROM product2 
                WHERE Id IN (SELECT Product2Id 
                            FROM OpportunityLineItem 
                            WHERE opportunityId IN (SELECT Id,Name,StageName, Plan_Number__c, Amount, Agency__c, AE_Cross_Sell_Partner__c, StartDate__c, EndDate__c, Deal__c 
                                                    FROM Opportunity 
                                                    WHERE Deal__c =: dealRecId))];
        
        List<OpportunityPropertyWrapper> opptyPropWrapper = new List<OpportunityPropertyWrapper>();
        for(Opportunity oppty : [SELECT Id,Name,StageName, Plan_Number__c, Amount, Agency__c, AE_Cross_Sell_Partner__c, StartDate__c, EndDate__c, Deal__c 
                                FROM Opportunity 
                                WHERE Deal__c =: dealRecId])
        {
            opportunityMap.put(oppty.Id, oppty);
        }

        for(Product2 prod : [SELECT Id, Name 
                            FROM product2 
                            WHERE Id IN (SELECT Product2Id 
                                        FROM OpportunityLineItem 
                                        WHERE opportunityId =: opportunityMap.keyset()])
        {
            for(OpportunityLineItem oli : prod.)
            oppPropMap.put()
        }

        for(OpportunityLineItem oli : [SELECT ID, Product2Id, Product2Id.name, OpportunityId, Opportunity.Name, Opportunity.StageName, Opportunity.Plan_Number__c, Opportunity.Amount, Opportunity.Agency__c, 
                                        Opportunity.AE_Cross_Sell_Partner__c, Opportunity.StartDate__c, Opportunity.EndDate__c, Deal__c 
                                        FROM OpportunityLineItem 
                                        WHERE OpportunityId IN (SELECT ID FROM Opportunity WHERE Deal__c =: dealRecId)])
        {
            oppLineItemMap.put(oli.Id, oli);
        }*/

    }

     // wrapper class with @AuraEnabled and {get;set;} properties 
     public class OpportunityPropertyWrapper{
        @AuraEnabled
        public List<Product2> propertiesList{get;set;}
        @AuraEnabled
        public Opportunity opportunityData{get;set;}
    }

}
