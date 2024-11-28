--Variables with / forward slash used to denote that values will be supplied through back end implementation

--Queries to select data for displaying tables to the user

SELECT * FROM Zoo;

SELECT * FROM Habitat;

SELECT * FROM Animal;

SELECT * FROM Employee;

SELECT * FROM doctorVisit;

--Queries to insert data into tables

INSERT INTO Zoo(zoo_Name, phone, email, num_Habs, num_Animals) VALUES
(/zoo_Name_Input, /phone_Input, /email_Input, /num_Habs_Input, /num_Animals_Input);
  
INSERT INTO Habitat(zoo_ID, hab_ID, hab_Enviroment, is_Open) VALUES
(/zoo_ID_Input, /hab_Name_Input, /hab_Enviroment_Input, /is_Open_Input);

INSERT INTO Animal(hab_ID, animal_Name, species, preferred_Enviroment, is_Healthy) VALUES
(/hab_ID_Input, /animal_Name_Input, /species_Input, /preferred_Enviroment_Input, /is_Healthy_Input);

INSERT INTO Employee(zoo_ID, writeups, employee_Name, position, comment) VALUES
(/zoo_ID_Input, /writeups_Input, /employee_Name_Input, /position_Input, /comment_Input);

INSERT INTO doctorVisit(animal_ID, reason, doctor_Note) VALUES
(/animal_ID_Input, /reason_Input, /doctor_Note_Input);


--Queries to edit data in tables

UPDATE Zoo 
SET zoo_Name = /zoo_Name_Input, phone = /phone_Input, email = /email_Input, num_Habs = /num_Habs_Input, num_Animals = num_Animals_Input
WHERE zoo_ID = /zoo_ID_From_Page;

UPDATE Habitat
SET zoo_ID = /zoo_ID_Input, hab_Name = /hab_Name_Input, hab_Enviroment = /hab_Enviroment_Input, is_Open = /is_Open_Input
WHERE hab_ID = /hab_ID_From_Page;

UPDATE Animal 
SET hab_ID = /hab_ID_Input, animal_Name = /animal_Name_Input, species = /species_Input, preferred_Enviroment = /preferred_Enviroment_Input, is_Healthy = /is_Healthy_Input
WHERE animal_ID = /animal_ID_From_Page;

UPDATE doctorVisit
SET animal_ID = /animal_ID_Input, reason = /reason_Input, doctor_Note = /doctor_Note_Input
WHERE visit_ID = /visit_ID_From_Page;

UPDATE Employee 
SET zoo_ID = /zoo_ID_Input, employee_Name = /employee_Name_Input, writeups = /writeups_Input, position = /position_Input, comment = /comment_Input
WHERE employee_ID = /employee_ID_From_Page;


--Queries to build M-M relationship for habitat and employee (Used for insert and update)

INSERT INTO HabitatEmployee(hab_ID, employee_ID) VALUES
(/hab_ID_Input, /employee_ID_Input); 


--Queries to delete data from tables

DELETE FROM Zoo WHERE zoo_ID = /zoo_ID_From_Page;

DELETE FROM Habitat WHERE hab_ID = /hab_ID_From_Page;

DELETE FROM Employee WHERE employee_ID = /employee_ID_From_Page;

DELETE FROM Animal WHERE animal_ID = /animal_ID_From_Page;

DELETE FROM doctorVisit WHERE visit_ID = /visit_ID_From_Page;


--Queries to remove M-M relationship for habitat and employee 

DELETE FROM HabitatEmployee WHERE hab_ID = /hab_ID_Input AND employee_ID = /employee_ID_Input;


--Querey to view the assigned employees from a given habitat

SELECT employee_ID, employee_Name FROM Employee IN (SELECT employee_ID FROM HabitatEmployee WHERE hab_ID = /hab_ID_From_Page);

--Querey to view the assigned habitats from a given employee 

SELECT hab_ID, hab_Name FROM Habitat IN (SELECT hab_ID FROM HabitatEmployee WHERE employee_ID = /employee_ID_From_Page);

--Querey to view employee comments for a given employee

SELECT comment FROM Employee WHERE employee_ID = employee_ID_From_Page;

--Querey to view doctor notes from given doctor vist

SELECT doctor_Note FROM doctorVisit WHERE visit_ID = /visit_ID_From_Page;




-- CRUD Operations for our M:M HabitatEmployee intersection table. --

-- CREATE (INSERT) operation: --
INSERT INTO HabitatEmployee(hab_ID, employee_ID)
VALUES (:hab_IDInput, :employee_IDInput)

-- UPDATE operation: --
UPDATE HabitatEmployee
SET hab_ID = :hab_IDInput, employee_ID = :employee_IDInput
WHERE habitatStatus_ID = :habitatStatus_IDInput

-- DELETE operation-- 
DELETE HabitatEmployee FROM HabitatEmployee WHERE habitatStatus_ID = :habitatStatus_IDInput

-- READ (SELECT) operation: --
SELECT hab_ID, employee_ID
FROM HabitatEmployee

