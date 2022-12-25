-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS sushi;

CREATE TABLE IF NOT EXISTS sushi.menu_types (
  id int AUTO_INCREMENT, 
  name varchar(30) NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sushi.menu_labels (
  id int AUTO_INCREMENT, 
  label varchar(50) NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sushi.menus (
  id int AUTO_INCREMENT, 
  menu_type_id int NOT NULL, 
  menu_label_id int NOT NULL,
  name varchar(30) NOT NULL,
  price int NOT NULL,
  can_be_taken_away boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (menu_type_id) REFERENCES sushi.menu_types(id),
  FOREIGN KEY (menu_label_id) REFERENCES sushi.menu_labels(id)
);

CREATE TABLE IF NOT EXISTS sushi.items (
  id int AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sushi.monthly_sales_per_item (
  item_id int NOT NULL,
  month int NOT NULL,
  is_eat_in boolean NOT NULL,
  includes_set_menu boolean NOT NULL,
  quantity int NOT NULL,
  price int NOT NULL,
  CONSTRAINT pk_monthly_sales PRIMARY KEY (item_id, month, is_eat_in, includes_set_menu),
  FOREIGN KEY (item_id) REFERENCES sushi.items(id)
);

CREATE TABLE IF NOT EXISTS sushi.menus_items (
  id int AUTO_INCREMENT,
  menu_id int NOT NULL,
  item_id int NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (menu_id) REFERENCES sushi.menus(id),
  FOREIGN KEY (item_id) REFERENCES sushi.items(id)
);

CREATE TABLE IF NOT EXISTS sushi.rice_size_type (
  id int AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sushi.customers (
  id int AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  phone_number varchar(15) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sushi.visits (
  id int AUTO_INCREMENT,
  customer_id int NOT NULL,
  is_eat_in boolean NOT NULL,
  visited_at datetime default current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES sushi.customers(id)
);

CREATE TABLE IF NOT EXISTS sushi.payments (
  id int AUTO_INCREMENT,
  visit_id int NOt NULL,
  total_price int NOT NULL,
  paid_at datetime default current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (visit_id) REFERENCES sushi.visits(id)
);

CREATE TABLE IF NOT EXISTS sushi.orders (
  id int AUTO_INCREMENT,
  visit_id int NOT NULL,
  memo varchar(200) NOT NULL,
  ordered_at datetime default current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (visit_id) REFERENCES sushi.visits(id)
);
