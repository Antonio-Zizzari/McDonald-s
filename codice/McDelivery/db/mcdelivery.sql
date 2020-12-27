drop database if exists mcdelivery;
create database mcdelivery;
use mcdelivery;

DROP user IF EXISTS 'mcdelivery'@'localhost';
CREATE USER 'mcdelivery'@'localhost' IDENTIFIED BY 'adminadmin';
GRANT ALL ON mcdelivery.* TO 'mcdelivery'@'localhost';

DROP TABLE IF EXISTS account;
CREATE TABLE account (
	mail varchar(50) NOT NULL,
	pwd varchar(64) NOT NULL,
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    tipo int NOT NULL,
    num_ordini int DEFAULT 0,
    PRIMARY KEY (mail)
);

DROP TABLE IF EXISTS prodotto;
CREATE TABLE prodotto (
	id int NOT NULL AUTO_INCREMENT,
    nome varchar(40) NOT NULL,
	prezzo int NOT NULL,
    tipo int NOT NULL,
    sconto int DEFAULT 0,
    photo varchar(200) NOT NULL,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS mcdrive;
CREATE TABLE mcdrive(
	nome varchar(40) NOT NULL,
	PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS indirizzo;
CREATE TABLE indirizzo(
	via varchar(50) NOT NULL,
	cap int NOT NULL,
	numero int NOT NULL,
	nome varchar(40) NOT NULL,
	PRIMARY KEY (via,cap,numero,nome),
	FOREIGN KEY (nome) REFERENCES mcdrive (nome)
);

DROP TABLE IF EXISTS indirizzoAcc;
CREATE TABLE indirizzoAcc(
	via varchar(50) NOT NULL,
	cap int NOT NULL,
	numero int NOT NULL,
	mail varchar(40) NOT NULL,
	PRIMARY KEY (via,cap,numero,mail),
	FOREIGN KEY (mail) REFERENCES account (mail)
);

DROP TABLE IF EXISTS ordine;
CREATE TABLE ordine(
	data date NOT NULL,
	numero int NOT NULL,
    totale int NOT NULL,
	mail varchar(50) NOT NULL,
	mc_nome varchar(40) NOT NULL,
    preso_in_carico int DEFAULT 0,
	PRIMARY KEY (data,numero),
	FOREIGN KEY (mail) REFERENCES account (mail),
	FOREIGN KEY (mc_nome) REFERENCES mcdrive (nome)
);

DROP TABLE IF EXISTS possiede;
CREATE TABLE possiede (
	data date NOT NULL,
	numero int NOT NULL,
	id int NOT NULL,
	quantita int DEFAULT 1,
	PRIMARY KEY (data,numero,id),
	FOREIGN KEY (data,numero) REFERENCES ordine (data,numero),
	FOREIGN KEY (id) REFERENCES prodotto (id)
	ON DELETE CASCADE
);

insert into account values
('albertobattaglia@gmail.com','3e15a6ba6776c9154dec00efd67d6ba5cf14714dfd7aa660821e6f8b816fcd33','Alberto','Battaglia',0,5),
('tonywindow99@virgilio.it','dc9bb2f67178c77eac597ab73bf9bf4d2d8cfc80440bb9bce84734bf2101486a','Antonio','Della Rovere',0,4),
('zizzariantonio@alice.it','5822af678a1a2dc2ffc0aef3880b931cb6fd6557471bfa52c6910d69302b33ab','Antonio','Zizzari',2,0),
('simonegiglio@hotmail.com','23f8f91456d47ef2d2b074f79001ef21b173dbe334455c74680a2997a7a7189b','Simone','Giglio',2,0),
('giusepptorn@gmail.it', '22ebd8191d8ea03b7d675fb7810c26c8da21348b7580fff1f3ef9f2a52b7c8c6', 'Giuseppe', 'Tornincasa', 3, 0),
('giosorrent@gmail.it', '54c425f135bdc915b6741e6aa55483e047c01f5519e225ac62b6b9828b5f7995', 'Giovanni Battista', 'Sorrentino', 3, 0),
('giancarlosavoiardo@gmail.com','5f51285267de269e2b3de1f2826f0715e6547e7b658e7c44035b7b63f830ef41','Giancarlo','Savoiardo',1,3),
('pinogiordy@gmail.org','8ea2a8cf9b5b488a2b33161bd74afa68dea2ff5fbc55eedabb3fa0c2849a185b','Pino','Giordano',1,4);


insert into mcdrive values
('McDrive Afragola'),
('McDrive Napoli'),
('McDrive Pompei'),
('McDrive Torre Annunziata');

insert into prodotto values
(1,'Acqua',1,1,0,'img/prodotti/bevande/acqua.png'),
(2,'Coca Cola',3,1,0,'img/prodotti/bevande/cocacola.png'),
(3,'Coca Cola Zero',3,1,0,'img/prodotti/bevande/cocacola_zero.png'),
(4,'Fanta',2,1,0,'img/prodotti/bevande/fanta.png'),
(5,'Sprite',2,1,0,'img/prodotti/bevande/sprite.png'),
(6,'McFlurry Bounty',3,2,0,'img/prodotti/gelati_e_dessert/mcflurry_bounty.png'),
(7,'McFlurry Oreo',3,2,0,'img/prodotti/gelati_e_dessert/mcflurry_oreo.png'),
(8,'McFlurry Snickers',3,2,0,'img/prodotti/gelati_e_dessert/mcflurry_snickers.png'),
(9,'MilkShake Banana',2,2,0,'img/prodotti/gelati_e_dessert/milkshake_banana.png'),
(10,'MilkShake Choco',2,2,0,'img/prodotti/gelati_e_dessert/milkshake_cioccolato.png'),
(11,'MilkShake Fragola',2,2,0,'img/prodotti/gelati_e_dessert/milkshake_fragola.png'),
(12,'MilkShake Vaniglia',2,2,0,'img/prodotti/gelati_e_dessert/milkshake_vaniglia.png'),
(13,'Sundae Caramello',1,2,0,'img/prodotti/gelati_e_dessert/sundae_caramello.png'),
(14,'Sundae Choco',1,2,0,'img/prodotti/gelati_e_dessert/sundae_cioccolato.png'),
(15,'Sundae Fiordilatte',1,2,0,'img/prodotti/gelati_e_dessert/sundae_fiordilatte.png'),
(16,'Sundae Frutti Rossi',1,2,0,'img/prodotti/gelati_e_dessert/sundae_frutti_rossi.png'),
(17,'Insalata Pollo',4,3,0,'img/prodotti/insalate/insalata_pollo_croccante.png'),
(18,'Insalata Verde',4,3,0,'img/prodotti/insalate/insalata_verde_pomodori.png'),
(19,'Big Mac',8,4,20,'img/prodotti/menu/mcmenu_bigmac.png'),
(20,'Crispy McBacon',7,4,0,'img/prodotti/menu/mcmenu_crispy_mcbacon.png'),
(21,'Double CheeseBurger',8,4,0,'img/prodotti/menu/mcmenu_doublecheeseburger.png'),
(22,'McChicken',8,4,0,'img/prodotti/menu/mcmenu_mcchicken.png'),
(23,'McNuggets',6,4,0,'img/prodotti/menu/mcmenu_mcnuggets_x6.png'),
(24,'McWrap',7,4,0,'img/prodotti/menu/mcmenu_mcwrap.png'),
(25,'MySelection BBQ',8,4,0,'img/prodotti/menu/mcmenu_myselection_bbq.png'),
(26,'MySelection Asiago',8,4,0,'img/prodotti/menu/mcmenu_myselection_asiago.png'),
(27,'BigMac',4,5,0,'img/prodotti/panini/bigmac.png'),
(28,'Cheeseburger',3,5,0,'img/prodotti/panini/cheeseburger.png'),
(29,'Chickenburger',1,5,0,'img/prodotti/panini/chickenburger.png'),
(30,'Crispy McBacon',4,5,0,'img/prodotti/panini/crispy-mcbacon.png'),
(31,'McChicken',4,5,0,'img/prodotti/panini/mcchicken.png'),
(32,'McWrap',4,5,0,'img/prodotti/panini/mcwrap.png'),
(33,'My Selection BBQ',8,5,0,'img/prodotti/panini/myselection_bbq.png'),
(34,'My Selection Chicken',8,5,0,'img/prodotti/panini/myselection_chicken_pepper.png'),
(35,'My Selection Asiago',8,5,0,'img/prodotti/panini/selection_asiago.png'),
(36,'Chicken Mcnuggets',3,6,0,'img/prodotti/sfiziosita/chicken_mcnuggets.png'),
(37,'Chicken Wings',3,6,0,'img/prodotti/sfiziosita/chicken_wings.png'),
(38,'Patatine Piccole',2,6,0,'img/prodotti/sfiziosita/patatine_piccole.png'),
(39,'Patatine Medie',3,6,0,'img/prodotti/sfiziosita/patatine_medie.png'),
(40,'Patatine XL Cheddar',4,6,0,'img/prodotti/sfiziosita/patatine_XL_cheddar.png'),
(41,'Patatine XL Cheddar & Bacon',5,6,0,'img/prodotti/sfiziosita/patatine_XL_cheddar_bacon.png');

insert into ordine values 
('2020-01-18',1,23,'tonywindow99@virgilio.it','McDrive Torre Annunziata',0),
('2020-01-18',2,11,'tonywindow99@virgilio.it','McDrive Afragola',0),
('2020-01-18',3,74,'albertobattaglia@gmail.com','McDrive Napoli',0),
('2020-01-15',1,8,'albertobattaglia@gmail.com','McDrive Torre Annunziata',0),
('2020-01-15',2,2,'tonywindow99@virgilio.it','McDrive Pompei',0),
('2020-01-15',3,35,'tonywindow99@virgilio.it','McDrive Pompei',0),
('2020-01-12',1,17,'tonywindow99@virgilio.it','McDrive Torre Annunziata',0),
('2020-01-12',2,10,'albertobattaglia@gmail.com','McDrive Napoli',0),
('2020-01-12',3,8,'albertobattaglia@gmail.com','McDrive Napoli',0),
('2020-01-12',4,250,'tonywindow99@virgilio.it','McDrive Afragola',0),
('2020-01-12',5,22,'tonywindow99@virgilio.it','McDrive Afragola',1),
('2020-01-12',6,14,'tonywindow99@virgilio.it','McDrive Torre Annunziata',1),
('2020-01-12',7,3,'albertobattaglia@gmail.com','McDrive Afragola',1),
('2019-12-20',1,6,'tonywindow99@virgilio.it','McDrive Afragola',1),
('2019-12-20',2,28,'tonywindow99@virgilio.it','McDrive Pompei',1),
('2019-12-20',3,11,'albertobattaglia@gmail.com','McDrive Afragola',1),
('2019-12-20',4,12,'tonywindow99@virgilio.it','McDrive Torre Annunziata',1),
('2019-12-20',5,10,'albertobattaglia@gmail.com','McDrive Napoli',1),
('2019-12-20',6,15,'tonywindow99@virgilio.it','McDrive Torre Annunziata',1),
('2019-12-20',7,8,'tonywindow99@virgilio.it','McDrive Pompei',1),
('2019-12-20',8,6,'albertobattaglia@gmail.com','McDrive Torre Annunziata',1),
('2019-12-20',9,16,'albertobattaglia@gmail.com','McDrive Napoli',1);

insert into indirizzo values
('Via Napoli',84294,14,'McDrive Torre Annunziata'),
('Via Roma',88054,11,'McDrive Napoli'),
('Via XX settembre',88354,34,'McDrive Afragola'),
('Via Toledo',80478,88,'McDrive Pompei');

insert into indirizzoAcc values
('Via Napoli',84294,14,'tonywindow99@virgilio.it'),
('Via Roma',88054,11,'albertobattaglia@gmail.com'),
('Via XX settembre',88354,34,'pinogiordy@gmail.org'),
('Via Bombis',80228,88,'giancarlosavoiardo@gmail.com'),
('Via Parco Vittoria',80448,18,'simonegiglio@hotmail.com'),
('Corso Vittorio Emanuele',80433,23,'zizzariantonio@alice.it'),
('Via del metallo',89550,41,'giusepptorn@gmail.it'),
('Via Rossa',85050,14,'giosorrent@gmail.it');

insert into possiede values
('2020-01-18',1,13,2),
('2020-01-18',2,10,2),
('2020-01-18',3,15,3),
('2020-01-15',1,8,3),
('2020-01-15',2,2,2),
('2020-01-15',3,21,1),
('2020-01-12',1,30,3),
('2020-01-12',2,10,4),
('2020-01-12',3,4,5),
('2020-01-12',4,11,2),
('2020-01-12',5,15,1),
('2020-01-12',6,16,4),
('2020-01-12',7,8,1),
('2019-12-20',1,13,1),
('2019-12-20',2,24,1),
('2019-12-20',3,11,4),
('2019-12-20',4,1,5),
('2019-12-20',5,23,7),
('2019-12-20',6,31,1),
('2019-12-20',7,4,3),
('2019-12-20',8,7,4),
('2019-12-20',9,18,2),
('2020-01-18',1,33,2),
('2020-01-18',2,9,2),
('2020-01-18',3,21,3),
('2020-01-15',1,7,3),
('2020-01-15',2,4,2),
('2020-01-15',3,32,1),
('2020-01-12',1,6,3),
('2020-01-12',2,8,4),
('2020-01-12',3,8,5),
('2020-01-12',4,8,2),
('2020-01-12',5,8,1),
('2020-01-12',6,5,4),
('2020-01-12',7,9,1),
('2019-12-20',1,1,1),
('2019-12-20',2,4,1),
('2019-12-20',3,1,4),
('2019-12-20',4,4,5),
('2019-12-20',5,15,7),
('2019-12-20',6,24,1),
('2019-12-20',7,12,3),
('2019-12-20',8,27,4),
('2019-12-20',9,11,2);