({
    handleShowNotice : function(component, event, helper) {
        component.find('notifLib').showNotice({
            "variant": "error",
            "header": "Something has gone wrong!",
            "message": "Unfortunately, there was a problem updating the record.",
            closeCallback: function() {
                alert('You closed the alert!');
            }
        });
    },

    handleShowToast : function(component, event, helper) {
        component.find('notifLib').showToast({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
    }
})