/*
Larsen Freund. Code mostly based off of the intended https://github.com/osu-cs340-ecampus/nodejs-starter-app/tree/main 
project.

*/

// Get the objects we need to modify
let addZooForm = document.getElementById('zooDataEntry');

// Modify the objects we need
addZooForm.addEventListener("submit", function (e) {
    
    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputZooName = document.getElementById("input-zoo_Name");
    let inputPhone = document.getElementById("input-phone");
    let inputEmail = document.getElementById("input-email");
    let inputHabitat = document.getElementById("input-num_Habs");
    let inputAnimal = document.getElementById("input-num_Animals");

    // Get the values from the form fields
    let inputZooValue = inputZooName.value;
    let inputPhoneValue = inputPhone.value;
    let inputEmailValue = inputEmail.value;
    let inputHabitatValue = inputHabitat.value;
    let inputAnimalValue = inputAnimal.value;

    // Put our data we want to send in a javascript object
    let data = {
        zoo_Name: inputZooValue,
        phone: inputPhoneValue,
        email: inputEmailValue,
        num_Habs: inputHabitatValue,
        num_Animals: inputAnimalValue

    }
    
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "/add-zoo-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            
            // Add the new data to the table
            addRowToTable(xhttp.response);

            // Clear the input fields for another transaction
            inputZooName.value = '';
            inputPhone.value = '';
            inputEmail.value = '';
            inputHabitat.value = '';
            inputAnimal.value = '';

        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }
    
    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


// Creates a single row from an Object representing a single record from 
// bsg_people
addRowToTable = (data) => {
    console.log(data);
    // Get a reference to the current table on the page and clear it out.
    let currentTable = document.getElementById("zooTable");

    
    // Get a reference to the new row from the database query (last object)
    let parsedData = JSON.parse(data);
    let newRow = parsedData[parsedData.length - 1]

    // Create a row and 4 cells
    let row = document.createElement("TR");
    let idCell = document.createElement("TD");
    let firstNameCell = document.createElement("TD");
    let lastNameCell = document.createElement("TD");
    let homeworldCell = document.createElement("TD");
    let ageCell = document.createElement("TD");

    // Fill the cells with correct data
    idCell.innerText = newRow.zoo_ID;
    firstNameCell.innerText = newRow.zoo_Name;
    lastNameCell.innerText = newRow.phone;
    homeworldCell.innerText = newRow.email;
    ageCell.innerText = newRow.num_Habs;
    ageCell.innerText = newRow.num_Animals;

    // rows will need delete buttons
    deleteCell = document.createElement("button");
    deleteCell.innerHTML = "Delete";
    deleteCell.onclick = function(){
        deleteZoo(newRow.zoo_ID);
    };
    // Add the cells to the row 
    row.appendChild(idCell);
    row.appendChild(firstNameCell);
    row.appendChild(lastNameCell);
    row.appendChild(homeworldCell);
    row.appendChild(ageCell);
    row.appendChild(deleteCell);
    row.setAttribute('data-value', newRow.zoo_ID);
    // Add the row to the table
    currentTable.appendChild(row);
}

function deleteRow(zoo_ID){
    let table = document.getElementById("zooTable");
    for (let i = 0, row; row = table.rows[i]; i++) {
       if (table.rows[i].getAttribute("data-value") == zoo_ID) {
            table.deleteRow(i);
            break;
       }
    }
}
function deleteZoo(zoo_ID) { // really wish we learned this bit by bit
    

    let data = {
      id: zoo_ID
    };
  
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();

    xhttp.open("DELETE", "/delete-zoo-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 204) {

            // Add the new data to the table
            deleteRow(zoo_ID);

        }
        else if (xhttp.readyState == 4 && xhttp.status != 204) {
            console.log("There was an error with the input. Please enter again.")
        }
    }
    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));
    }
  
