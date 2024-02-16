import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';


export default class RelatedContacts extends LightningElement {

    @api recordId; 
    @api objectApiName;
    error;
    records; 

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Contacts',
        fields: ['Contact.Id','Contact.Name','Contact.Email'],
        sortBy: ['Contact.Name']
    })
    listInfo({ error, data }) {
        if (data) {
          this.records = data.records;
          this.error = undefined;
        } else if (error) {
          this.error = error;
          this.records = undefined;
        }
    }
}