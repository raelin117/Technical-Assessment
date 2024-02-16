import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';


export default class AccountEditor extends LightningElement {

    fields = [NAME_FIELD];
    @api recordId; 
    @api objectApiName;

    handleSubmit(event) {
        event.preventDefault(); 
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-form').submit(fields);
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Account Updated',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}