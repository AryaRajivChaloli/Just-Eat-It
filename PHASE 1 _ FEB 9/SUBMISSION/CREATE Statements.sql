CREATE TABLE User
(
  User_First_Name VARCHAR(10) NOT NULL,
  User_Middle_Name VARCHAR(10),
  User_Last_Name VARCHAR(10) NOT NULL,
  User_Email_Id VARCHAR(100) NOT NULL,
  User_Phone_No INTEGER NOT NULL,
  User_Password VARCHAR(50) NOT NULL,
  PRIMARY KEY (User_Email_Id),
  UNIQUE (User_Phone_No)
);

CREATE TABLE Restaurant
(
  Restaurant_Name VARCHAR(100) NOT NULL,
  Restaurant_Cost_Range DECIMAL(10,2) NOT NULL,
  Restaurant_FSSAI_No INTEGER NOT NULL,
  Restaurant_Location VARCHAR(100) NOT NULL,
  Restaurant_Rating INTEGER NOT NULL,
  Restaurant_Password VARCHAR(100) NOT NULL,
  Restaurant_Website VARCHAR(100) NOT NULL,
  PRIMARY KEY (Restaurant_FSSAI_No),
  UNIQUE (Restaurant_Website)
  CHECK (Restaurant_Cost_Range > 0),
  CHECK (Restaurant_Rating >= 0 AND Restaurant_Rating <= 5)
);

CREATE TABLE Item
(
  Item_Id INTEGER NOT NULL,
  Item_Price DECIMAL(10,2) NOT NULL,
  Item_Name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Item_Id),
  CHECK (Item_Price > 0)
);

CREATE TABLE Agents
(
  Agent_Vehicle_No VARCHAR(11) NOT NULL,
  Agent_Phone_No INTEGER NOT NULL,
  Agent_First_Name VARCHAR(10) NOT NULL,
  Agent_Middle_Name VARCHAR(10),
  Agent_Last_Name VARCHAR(10) NOT NULL,
  PRIMARY KEY (Agent_Vehicle_No),
  UNIQUE (Agent_Phone_No)
);

CREATE TABLE Agents_Areas
(
  Agent_Area VARCHAR(100) NOT NULL,
  Agent_Vehicle_No VARCHAR(11) NOT NULL,
  PRIMARY KEY (Agent_Area, Agent_Vehicle_No),
  FOREIGN KEY (Agent_Vehicle_No) REFERENCES Agents(Agent_Vehicle_No)
);

CREATE TABLE Caters
(
  Restaurant_FSSAI_No INTEGER NOT NULL,
  Item_Id INTEGER NOT NULL,
  PRIMARY KEY (Restaurant_FSSAI_No, Item_Id),
  FOREIGN KEY (Restaurant_FSSAI_No) REFERENCES Restaurant(Restaurant_FSSAI_No),
  FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id)
);

CREATE TABLE Prefers
(
  User_Email_Id VARCHAR(100) NOT NULL,
  Item_Id INTEGER NOT NULL,
  PRIMARY KEY (User_Email_Id, Item_Id),
  FOREIGN KEY (User_Email_Id) REFERENCES User(User_Email_Id),
  FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id)
);

CREATE TABLE Order
(
  Order_No INTEGER NOT NULL,
  User_Email_Id VARCHAR(100) NOT NULL,
  Restaurant_FSSAI_No INTEGER NOT NULL,
  PRIMARY KEY (Order_No),
  FOREIGN KEY (User_Email_Id) REFERENCES User(User_Email_Id),
  FOREIGN KEY (Restaurant_FSSAI_No) REFERENCES Restaurant(Restaurant_FSSAI_No)
);

CREATE TABLE User_Address
(
  House_No INTEGER NOT NULL,
  Street_No VARCHAR(20) NOT NULL,
  Area_Name VARCHAR(50) NOT NULL,
  User_Email_Id VARCHAR(100) NOT NULL,
  PRIMARY KEY (House_No, Street_No, Area_Name, User_Email_Id),
  FOREIGN KEY (User_Email_Id) REFERENCES User(User_Email_Id)
);

CREATE TABLE Ordered_Items
(
  Order_No INTEGER NOT NULL,
  Item_Id INTEGER NOT NULL,
  PRIMARY KEY (Order_No, Item_Id),
  FOREIGN KEY (Order_No) REFERENCES Order(Order_No),
  FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id)
);

CREATE TABLE Delivery
(
  Restaurant_Area VARCHAR(100) NOT NULL,
  Delivery_Id INTEGER NOT NULL,
  User_Area VARCHAR(100) NOT NULL,
  Agent_Vehicle_No VARCHAR(11) NOT NULL,
  Order_No INTEGER NOT NULL,
  PRIMARY KEY (Delivery_Id),
  FOREIGN KEY (Agent_Vehicle_No) REFERENCES Agents(Agent_Vehicle_No),
  FOREIGN KEY (Order_No) REFERENCES Order(Order_No)
);

CREATE TABLE Payment
(
  Payment_Id INTEGER NOT NULL,
  Mode_of_Payment VARCHAR(10) NOT NULL,
  Total_Price DECIMAL(10,2) NOT NULL,
  Order_No INTEGER NOT NULL,
  PRIMARY KEY (Payment_Id),
  FOREIGN KEY (Order_No) REFERENCES Order(Order_No),
  CHECK (Total_Price > 0)
);