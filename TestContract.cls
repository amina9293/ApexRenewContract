@isTest
public class TestContract
{
            	@isTest static void createContract()
                {
                // Create an account     
                account a 				= new account();
                a.Name 					= 'sisi';
                    
                insert a;
                
                // Create a user    
                User myUser      		= new User();
       			myUser.FirstName 		= 'Sansa';
      			myUser.LastName  		= 'Stark';
        		myUser.Email    		= 'sstark@winterfellhotels.com';
       		    myUser.Username  		= 'sstark@winterfellhotels.com';
       		    myUser.Alias     		= 'redhead';
       		    myUser.ProfileId 		=  [ SELECT Id 
        								 FROM Profile
        								 WHERE Name = 'System Administrator'].Id;
       		   myUser.TimeZoneSidKey    = 'America/Denver';
       		   myUser.LocaleSidKey      = 'en_US';
       		   myUser.EmailEncodingKey  = 'UTF-8';
       		   myUser.LanguageLocaleKey = 'en_US';
       		 
       		   insert myUser;
                   
                 // Create a contract  
                contract c					= new contract(); 
                c.AccountId					= a.id;
				c.Status					= 'Brouillon';
				c.OwnerId					= myuser.Id;
				c.Tacite_reconduction__c	= false;
				c.Type_de_contract__c		= 'DON';
				c.Montant__c				= 0;
				c.StartDate					= date.today();
				c.ContractTerm				= 12;
				c.OwnerExpirationNotice		= '90';
				c.CompanySignedId			= '0051t000002m5m6AAA';
				c.CompanySignedDate			= date.today();
				c.CustomerSignedId			= '0031t00000JYE1jAAH';
				c.CustomerSignedDate		= date.today();
				
                  insert c ;  
                    
                    
                 Contentversion Cd = new contentversion();
                    cd.Title 	   = '1000px-Apple_logo_black.svg';
                    cd.ContentUrl  = 'https://www.theurldr.com/apple-logo/';
                    
                 insert cd;
                    
                 ContentDocumentlink cdl  = new ContentDocumentlink();
                    cdl.ShareType 		  = 'V';
                    cdl.LinkedEntityId    = c.id;
                    cdl.Visibility        = 'AllUsers';
                    cdl.ContentDocumentId = [SELECT Id
                                               FROM Contentdocument
                                              WHERE title = '1000px-Apple_logo_black.svg'].id;
                    
                    insert cdl;
                                             		
                     
 				list<contract> ensemble_contrat = new list<contract>();
                ensemble_contrat.add(c);
               
                //Create a new record in the "montant contrat" object 
                montant_contrat__c mtmc = new montant_contrat__c();
                mtmc.contrat__c= c.ID;
                mtmc.Montant__c = 1500;
                insert mtmc; 
                 
                    
                Test.startTest();
                 RenouvellementContratTaciteCLASS.createTaciteContract(ensemble_contrat);
				Test.StopTest();
                    
                list<contract> Con = [SELECT id FROM Contract WHERE accountid = :a.id ];
				System.assertEquals(2, con.size());
                }
}