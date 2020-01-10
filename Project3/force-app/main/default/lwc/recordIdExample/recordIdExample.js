import { LightningElement,api,wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactData.getContacts';
 
export default class RecordIdExample extends LightningElement {
    @api recordId;
    
    @wire(getContacts, {accId:'$recordId' })
      contacts;
}