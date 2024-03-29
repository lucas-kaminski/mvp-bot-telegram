CREATE DATABASE FINANCIAL;
USE FINANCIAL;

CREATE TABLE IF NOT EXISTS users (
	  ID INT NOT NULL AUTO_INCREMENT,
	  TELEGRAM_ID BIGINT UNIQUE,
	  STRIPE_ID VARCHAR(255) UNIQUE,
	  NAME VARCHAR(255) NOT NULL,
	  EMAIL VARCHAR(255),
	  PHONE VARCHAR(255),
	  STATUS VARCHAR(255) NOT NULL,
	  PRIMARY KEY (ID, TELEGRAM_ID)
	);

CREATE TABLE IF NOT EXISTS adms(
  ID INT NOT NULL AUTO_INCREMENT,
  USER_ID INT NOT NULL UNIQUE,
  PASSWD VARCHAR(255) NOT NULL,
  ADM_ROLE VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (USER_ID) REFERENCES users(ID) ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS products (
          ID INT NOT NULL AUTO_INCREMENT,
          STRIPE_ID VARCHAR(255),
          NAME VARCHAR(255) NOT NULL,
          DESCRIPTION VARCHAR(255),
          PRICE FLOAT NOT NULL,
          VALIDITY_IN_MONTHS INT NOT NULL,
          PRIMARY KEY (ID)
        );

CREATE TABLE IF NOT EXISTS vip_users (
  ID INT NOT NULL AUTO_INCREMENT,
  USER_ID INT NOT NULL,
  PRODUCT_ID INT NOT NULL,
  EXPIRATION DATE NOT NULL,
  STATUS VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (USER_ID) REFERENCES users(ID) ON DELETE CASCADE,
  FOREIGN KEY (PRODUCT_ID) REFERENCES products(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS channels (
  ID INT NOT NULL AUTO_INCREMENT,
  TELEGRAM_ID BIGINT UNIQUE,
  NAME VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS analises (
  ID INT NOT NULL AUTO_INCREMENT,
  TITLE VARCHAR(255),
  BODY TEXT NOT NULL,
  LINK VARCHAR(255),
  AUTHOR_ID INT NOT NULL,
  UPDATED_AT DATETIME NOT NULL,
  EDITED_AT DATETIME NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (AUTHOR_ID) REFERENCES adms(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS trades (
	ID INT NOT NULL AUTO_INCREMENT,
	SYMBOL VARCHAR(255) NOT NULL,
    CREATED_BY INT NOT NULL,
	UPDATED_AT DATETIME NOT NULL,
	EDITED_AT DATETIME NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (CREATED_BY) REFERENCES adms(ID) ON DELETE CASCADE
);
