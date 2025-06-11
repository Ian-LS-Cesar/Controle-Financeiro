    // filepath: c:\Users\guada\Controle-Financeiro\assets\js\transaction.js
    document.addEventListener("DOMContentLoaded", () => {
    const transactionForm = document.getElementById("transaction-form");
    
    if (transactionForm) {
        transactionForm.addEventListener("submit", (event) => {
        event.preventDefault();
        const formData = new FormData(transactionForm);
        
        fetch(transactionForm.action, {
            method: transactionForm.method,
            body: formData,
            headers: {
            'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute("content")
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
            // Handle successful transaction
            alert("Transaction successful!");
            // Optionally, reset the form or update the UI
            transactionForm.reset();
            } else {
            // Handle errors
            alert("Transaction failed: " + data.error);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("An error occurred. Please try again.");
        });
        });
    }
    });