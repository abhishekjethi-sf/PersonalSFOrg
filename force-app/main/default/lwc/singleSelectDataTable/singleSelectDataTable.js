import { LightningElement,api } from 'lwc';

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Account Rating', fieldName: 'Rating' }
];

export default class SingleSelectDataTable extends LightningElement {
    tableColumns = columns;
    @api recordList = 'Test';
}