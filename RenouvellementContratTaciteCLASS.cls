public class RenouvellementContratTaciteCLASS
	{
    
    @InvocableMethod
    
    	public static void createTaciteContract(Contract[] Contrat_a_renouveler)
        {
    

         
        	for(Contract initialC : Contrat_a_renouveler)
        	{
             
                 
            			Contract c				= new contract();
            			c.AccountId				= InitialC.AccountId;
				c.Status				= 'brouillon';
				c.OwnerId				= InitialC.OwnerId;
				c.Tacite_reconduction__c		= true;
				c.Type_de_contract__c			= InitialC.Type_de_contract__c;
				c.Sous_type_de_contrat__c		= InitialC.Sous_type_de_contrat__c;
				c.Montant__c				= InitialC.Montant__c;
				c.StartDate				= InitialC.startDate.AddMonths(12);
                		c.ContractTerm				= 12;
				c.OwnerExpirationNotice			= '90';
				c.Billingcity				= InitialC.Billingcity;
				c.Billingcountry			= InitialC.Billingcountry;
				c.BillingpostalCode			= InitialC.BillingpostalCode;
				c.Billingstate				= InitialC.Billingstate;
				c.Billingstreet				= InitialC.Billingstreet;
				c.CompanySignedId			= InitialC.CompanySignedId;
				c.CompanySignedDate			= InitialC.CompanySignedDate;
				c.CustomerSignedId			= InitialC.CustomerSignedId;
				c.CustomerSignedDate			= InitialC.CustomerSignedDate;
				c.Shippingcity				= InitialC.Shippingcity;
				c.Shippingcountry			= InitialC.Shippingcountry;
				c.ShippingpostalCode		        = InitialC.ShippingpostalCode;
				c.Shippingstate				= InitialC.Shippingstate;
				c.Shippingstreet			= InitialC.Shippingstreet;
               			c.ancien_contrat__c			= InitialC.id;
 				
                		insert c;
                
                
        		//recuperation des fichiers joints
                List<ContentDocumentlink> cdlList = [SELECT Id,
                                             		    ShareType,
                                             		    LinkedEntityId, 
                                             		    ContentDocumentId
                                               	       FROM ContentDocumentlink
                                                      WHERE LinkedEntityId = :InitialC.Id];
                // System.debug(cdlList.size());
            	if(cdlList != null)
                {
            
        			for(ContentDocumentLink file: cdlList)
                	{
            
  						ContentDocumentLink cloneFile     = file.clone();
  						cloneFile.linkedentityid 	  = c.Id; 
            
           				insert cloneFile;
        			}
                }
                
                //creation montant contrat
                montant_contrat__c ancien_montant = [select montant__c 
                                    from montant_contrat__c 
                                    where (Contrat__c = :InitialC.Id )
                                     limit 1];
               if(ancien_montant != null)
                {
                	montant_contrat__c New_montant = new montant_contrat__c();
               		new_montant.name= 'automatique';
                    new_montant.Contrat__c = c.id;
               		new_montant.Montant__c = ancien_montant.montant__c;
                	insert new_montant;
                } 
            }
		}            
	}
