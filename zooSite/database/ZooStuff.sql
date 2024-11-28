  DROP TABLE IF EXISTS HabitatEmployee;
  DROP TABLE IF EXISTS doctorVisit;
  DROP TABLE IF EXISTS Employee;
  DROP TABLE IF EXISTS Animal;
  DROP TABLE IF EXISTS Habitat;
  DROP TABLE IF EXISTS Zoo;

  SET FOREIGN_KEY_CHECKS=0;
  SET AUTOCOMMIT = 0;
  CREATE OR REPLACE TABLE Zoo(
    zoo_ID int(11) NOT NULL AUTO_INCREMENT,
    zoo_Name varchar(64) not NULL,
    phone varchar(16),
    email varchar(128),
    num_Habs int(11),
    num_Animals int(11),
    PRIMARY KEY(zoo_ID,zoo_Name), -- HMMM
    CONSTRAINT uniName UNIQUE(zoo_Name)
  );

  CREATE OR REPLACE TABLE Habitat(
    hab_ID int(11) NOT NULL AUTO_INCREMENT,
    zoo_ID int(11),
    hab_Name varchar(64) NOT NULL,
    hab_Enviroment varchar(32) NOT NULL,
    is_Open boolean,
    PRIMARY KEY(hab_ID),
    FOREIGN KEY(zoo_ID) REFERENCES Zoo(zoo_ID),
    CONSTRAINT uniHabName UNIQUE(hab_Name)

  );

  CREATE OR REPLACE TABLE Animal(
    animal_ID int(11) NOT NULL AUTO_INCREMENT,
    hab_ID int(11),
    animal_Name VARCHAR(128) NOT NULL,
    species VARCHAR(128) NOT NULL,
    preferred_Enviroment VARCHAR(32) NOT NULL,
    is_Healthy boolean,
    PRIMARY KEY(animal_ID),
    FOREIGN KEY(hab_ID) REFERENCES Habitat(hab_ID),
    CONSTRAINT uniAnimalName UNIQUE(animal_Name)

  );

  CREATE OR REPLACE TABLE doctorVisit(
    visit_ID int(11) NOT NULL AUTO_INCREMENT,
    animal_ID int(11),
    reason VARCHAR(128) NOT NULL,
    doctor_Note VARCHAR(128),
    PRIMARY KEY(visit_ID),
    FOREIGN KEY(animal_ID) REFERENCES Animal(animal_ID)
  );

  CREATE OR REPLACE TABLE Employee(
    employee_ID int(11) NOT NULL AUTO_INCREMENT,
    zoo_ID int(11),
    writeups int(11),
    employee_Name varchar(64),
    position VARCHAR(128) NOT NULL,
    comment VARCHAR(1024) NOT NULL,
    PRIMARY KEY(employee_ID),
    FOREIGN KEY(zoo_ID) REFERENCES Zoo(zoo_ID),
    CONSTRAINT uniEmployName UNIQUE(employee_Name)

  );
  
  CREATE OR REPLACE TABLE HabitatEmployee(
    hab_ID int(11),
    employee_ID int(11),
    FOREIGN KEY(hab_ID) REFERENCES Habitat(hab_ID),
    FOREIGN KEY(employee_ID) REFERENCES Employee(employee_ID)

  );