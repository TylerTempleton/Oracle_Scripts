/*
DESCRIPTION
File:               assignment 2 insert
Author:             TYLER TEMPLETON
Oracle username:    S11_112
Description:
Assignment 2 Insert
Follow the instructions for Create Specialty Import Insertions AND Multi-user Insertion
*/

SET LINESIZE 132
SET PAGESIZE 255

/*
customer table
For customer table we are going to register two different type of customers; one that is going to buy a car by trading in his/her old one, and another customer who is not buying any cars, but has come to Specialty Imports for servicing. Use your name pretending to be the customer who is trading the car for a new one, and another fictitious name as a customer that has come to service his/her car.
The phone numbers must be in the format: (000)000-0000
*/


INSERT INTO customer (cname, cstreet, ccity, cprov, cpostal,chphone,cbphone)
     VALUES ('Tyler Templeton', 'New Street', 'Burlington', 'Ontario','l7r1j8','5551234678', null);
INSERT INTO customer (cname, cstreet, ccity, cprov, cpostal,chphone,cbphone)
     VALUES ('Tommy Wiesau', 'The Room', 'Hollywood', 'Ontario','R0O0M5','555446275','555424242');
 

/*
Car Table
You are going to register (insert) three cars into the car table. Two of the cars are going to be old cars belonging to those 
customers you inserted into customer table earlier. Remember that old cars do not have purchinv, purchdate, purchfrom, purchcost,
freightcost, totalcost and listprice because SI did not purchase those cars and they are not for sale. The third car will be a 
new car purchased form the manufacturer and it will be available for sale. It will be later sold to you using your old car as a 
trade in. New cars are only:

ACURA, LAND ROVER , MERCEDES, JAGUAR
Primary key for the cars must be manually created by you using the following pattern:
first letter of the car make
followed by 2 digits for the year,
1 character for the color,
3 characters for the car model and
1 digit number.

Use the one digit number to make your serial number unique from others if needed. Make most, but not all, car years either 
current year or past year. Make yourself and the fictitious customer you created earlier the owners of the two old cars by 
placing the names to the car table (cname). The new car will have cname value as null because it has no owner yet. It is 
available for sale and you are going to sell it to yourself in step 7 below
 */
     
	 
INSERT INTO  car(serial,cname,make, model, cyear,color, trim, enginetype,purchdate,purchfrom,purchcost,freightcost,listprice)
    VALUES ('C57RBAS9','Tyler Templeton','Chevy','BelAir','1957','Red','Leather','TurboFire',NULL,NULL,NULL,NULL,NULL);
INSERT INTO  car(serial,cname,make, model, cyear,color, trim, enginetype,purchdate,purchfrom,purchcost,freightcost,listprice)
    VALUES ('H02WSIR7','Tommy Wiesau','Honda','Civic','2002','White','Standard',' K20A3',NULL,NULL,NULL,NULL,NULL);
INSERT INTO  car(serial,cname,make, model, cyear,color, trim, enginetype,purchdate,purchfrom,purchcost,freightcost,listprice)
    VALUES ('A19PMDX7',NULL,'Acura','MDX','2018','Purple','Wood','V6','2018-01-12','Acura',35000,500,54090);
 
/*
 Baseoption Table
Insert two manufacturer's options into baseoption table for the new car. Print the options table to see valid options. 
(Instructions below).
Old cars do not have any baseoption
 */
 
 
INSERT INTO  baseoption(serial,ocode)
    VALUES ('A19PMDX7','SD1');
INSERT INTO  baseoption(serial,ocode)
    VALUES ('A19PMDX7','S22');
    
/*
    Saleinv Table
This is where you are going to sell the car to yourself by inserting one record into saleinv table.
Use 'I' in the SALEINV field and concatenate it (use ||) to TO_CHAR(saleinv_seq.NEXTVAL, 'FM00000'). saleinv_seq is the 
sequence you created with your table definitions. If you have not created the sequences in your assignment 1 create two sequences
called saleinv_seq and servinv_seq and run your assignment 1 script to add them.serial is the serial number of the new car and
tradeserial is the serial number of the car you are trading in. (old one)Make sure to enter as salesman one of the names of the 
sales people found in employee table.Many of the fields in the saleinv table allow null vales, but you must have real values in
them. The values must also make sense:
net = totalprice - discount
tax = 0.13 * net
commission = employee.commissionrate * net. (commissionrate can be found in employee table alongside the salesman name)
*/

INSERT INTO  saleinv(saleinv,cname,salesman,saledate,serial,totalprice, discount,net,tax, licfee, commission, tradeserial,tradeallow, fire,collision,liability,property)
    VALUES (
    'I'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM00000'),'Tommy Wiesau','ADAM ADAMS','2018-02-14','A19PMDX7',25000.00,1200.00 ,23800,0.13*23800,200,0.10*23800, 'H02WSIR7', 500.00,'Y','Y','Y','Y');
   
    
INSERT INTO  saleinv(saleinv,cname,salesman,saledate,serial,totalprice, discount, net, tax, licfee, commission, tradeserial,tradeallow, fire,collision,liability,property)
    VALUES (
    'I'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM00000'),'Tommy Wiesau','ADAM ADAMS','2018-02-14','A19PMDX7',26000.00,2200.00 ,23800,0.13*23800,200,0.10*23800, 'H02WSIR7', 500.00,'Y','Y','Y','Y');
    
/*
Update car table
After the sale is completed, the car table needs to be updated:
The new car needs to have as cname the name of the customer that
bought it (you); instead of previously entered NULL value
*/
update  car
SET cname = 'Tyler Templeton'
where serial = 'A19PMDX7'
;

/*
The old car, which was used as a trade-in, must also change owner from the existing name (you) to NULL. 
This car will be now available for sale and can be sold to someone else.
All the fields that previously were null in the trade-in car,
(purchinv, purchdate, purchfrom, purchcost, freightcost, totalcost and listprice ) must now have values. 
These values must also make sense:purchdate is the same date the trade-in happened, which is the same date the new car
in the saleinv was sold (saledate).purchfrom is the name of the customer the car was purchased from (you)freightcost usually is 
0, because the customer would normally drop off the car at no cost. totalcost = purchcost + freightcost listprice > totalcost, 
otherwise it will not make business sense
*/


update  car
SET cname = NULL,purchinv='TNT123',purchdate = '2018-02-14',purchfrom= 'Tyler T',purchcost = 1200,freightcost=0, totalcost = 1200,listprice = 2400
where serial = 'C57RBAS9'
;

/*
invoption table
Insert two appropriate invoption records. Remember the ocode must be one of the codes on the options table and saleprice in invoption must be greater than or equal to olist of options table.
Use saleinv_seq sequence you created with your table definitions using "I || TO_CHAR(saleinv_seq.CURRVAL, 'FM00000')".
*/

INSERT INTO  invoption(saleinv,ocode, saleprice)
    VALUES ('I'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM00000'),'SD1',500.00 );
INSERT INTO  invoption(saleinv,ocode, saleprice)
    VALUES ('I'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM00000'),'S22',387.00);
/*
prospect table
Insert yourself into the prospect table twice. You may leave null values for some of the fields that allow them.
*/

INSERT INTO  prospect(cname,make,model,cyear,color,trim,ocode)
    VALUES ('Tyler Templeton','ACURA',NULL,NULL,NULL,NULL,Null);
INSERT INTO  prospect(cname,make,model,cyear,color,trim,ocode)
    VALUES ('Tyler Templeton','Jaguar','UX','2001','Black','Leather','U20');
    
/* 
servinv table
Insert two records into the servinv table
for one of cars that is currently owned by the fictitious
customer you inserted earlier . 
This time concatenate 'W' to a sequence generated number 
from the servinv_seq (Use -> TO_CHAR(servinv_seq.NEXTVAL, 'FM0000'))
*/


drop table servinv;
INSERT INTO  servinv(servinv,serdate,cname,serial,partscost,laborcost,tax,totalcost)
    VALUES ('W'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM0000'),'2018-02-14','Tommy Wiesau','H02WSIR7',200,300,65,565);
INSERT INTO  servinv(servinv,serdate,cname,serial,partscost,laborcost,tax,totalcost)
    VALUES ('W'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM0000'),'2018-02-14','Tommy Wiesau','H02WSIR7','500.00','500',130 ,1130 );
  
/*
servwork table
Insert two records for each servinv into servwork
You must insert each record into the servwork table immediately after its corresponding record of servinv table to be able to match the foreign key value to the primary key using servinv_seq.CURRVAL
*/

INSERT INTO servwork(servinv, workdesc)
    VALUES ('W'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM0000'),'bumbper replacement');   
INSERT INTO servwork(servinv, workdesc)
    VALUES ('W'||TO_CHAR(SALEINV_SEQ.NEXTVAL,'FM0000'),'removed damage from hood, repaint ');   
    

    
COMMIT;

/*
-------------------- OUTPUT RESULT START ---------------------------
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row updated.
1 row updated.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
commit complete
-------------------- OUTPUT RESULT END -----------------------------
*/
