-- TO DO
INSERT INTO Zoo(
    zoo_Name,
    phone,
    email,
    num_Habs,
    num_Animals
) VALUES ('Grand Forest Zoo',2538531233,'zoocontact@grandforestzoo.com',12,120);

INSERT INTO Habitat(
    zoo_ID,
    hab_Name,
    hab_Enviroment,
    is_Open
) VALUES ((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),'The Arctic Park','Tundra',1),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),'Swampland','Swamp',0),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),'Desert Dome','Desert',1);

INSERT INTO Animal(
    hab_ID,
    animal_Name,
    species,
    preferred_Enviroment,
    is_Healthy
) VALUES ((SELECT hab_ID FROM Habitat WHERE hab_Name = 'Desert Dome'),'Corny','zea mays','Desert',1),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'Desert Dome'),'Peter','H. suspectum','Desert',1),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'Desert Dome'),'Looney','G. californianus','Desert',0),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'Swampland'),'Alvin','Crocodylus porosus','Swamp',1),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'Swampland'),'Mary','Axis','Desert',1),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'The Arctic Park'),'Icy','Channichthyidae','Tundra',1),
((SELECT hab_ID FROM Habitat WHERE hab_Name = 'The Arctic Park'),'Pablo','Troglodytes gorilla','PrimateArea',0);

INSERT INTO doctorVisit(
    animal_ID,
    reason,
    doctor_Note
) VALUES ((SELECT animal_ID FROM Animal WHERE animal_Name = 'Corny'),'Not growing','Administer meds to corny during closing hours'),
((SELECT animal_ID FROM Animal WHERE animal_Name = 'Peter'),'will not eat and dead skin on back','Peter is stressed by crowds, it needs to be in a quieter enclosure'),
((SELECT animal_ID FROM Animal WHERE animal_Name = 'Pablo'),'constantly shivering, hiding','PABLO SHOULD NOT BE IN TUNDRA');

INSERT INTO Employee(
    zoo_ID,
    writeups,
    employee_Name,
    position,
    comment
) VALUES ((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),0,"Ethan",'Desert Worker','no vacation days left'),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),1,"Morris",'Desert Worker','Do not let near lions'),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),0,"Leena",'Swamp Worker','birthday 2/3'),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),5,"Martin",'Arctic Worker','no comment'),
((SELECT zoo_ID FROM Zoo WHERE zoo_Name = 'Grand Forest Zoo'),2,"Sarah",'Swamp Worker','no comment');

INSERT INTO HabitatEmployee(
    hab_ID,
    employee_ID
) VALUES((SELECT hab_ID FROM Habitat WHERE hab_Name = "Desert Dome"),(SELECT employee_ID FROM Employee WHERE employee_Name = "Ethan")),
((SELECT hab_ID FROM Habitat WHERE hab_Name = "Desert Dome"),(SELECT employee_ID FROM Employee WHERE employee_Name = "Morris")),
((SELECT hab_ID FROM Habitat WHERE hab_Name = "Swampland"),(SELECT employee_ID FROM Employee WHERE employee_Name = "Leena")),
((SELECT hab_ID FROM Habitat WHERE hab_Name = "The Arctic Park"),(SELECT employee_ID FROM Employee WHERE employee_Name = "Martin")),
((SELECT hab_ID FROM Habitat WHERE hab_Name = "Swampland"),(SELECT employee_ID FROM Employee WHERE employee_Name = "Sarah"));



select * from Zoo;
select * from Habitat;
select * from Employee;
select * from Animal;
select * from HabitatEmployee;
select * from doctorVisit;





