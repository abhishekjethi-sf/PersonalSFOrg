import { LightningElement, track, api } from 'lwc';

export default class App extends LightningElement {
    name='Abhishek Jethi';
    address = 'Schofields';
    inputText = 'Input Value';

    handleInputChange(event){
        const inputValue = event.target.value;
        const inputLabel = event.target.label;
        console.log('Label is ' + inputLabel + ' and value is ' + inputValue);
    }

    handleOnBlur(event){
        const inputLabel = event.target.label;
        console.log('Label is ' + inputLabel);
    }   
}