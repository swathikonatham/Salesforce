import { LightningElement, wire, track, api } from 'lwc';

//import method from the Apex Class to get the records
import fetchopportunities from '@salesforce/apex/OpportunityListViewController.getOpportunityList';

export default class OpportunityHierarchyListView extends LightningElement {
    @api recordId; //Get Deal ID 
    @track error;
    @track opptyList;
    @track data = {};

    @wire(fetchopportunities, {dealRecId: '$recordId' })
    wiredOpportunities({
        error,
        data
    }) {
        if (data) {
            topptyList = data;
        } else if (error) {
            this.error = error;
        }
    }
}