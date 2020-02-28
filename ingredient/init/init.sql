/* -------------------- BEGIN SCHEMA -------------------- */

/*
 * User Map Table
 * maps a globally recognized MongoDB user ID to a ingredient-internal
 * id
 */
create table user_map
(
    id int primary key,
    external_id varchar(24)
);

/*
 * Unit Category Table
 * resolves specific units to volume, weight, or unit
 */
create table unit_category
(
    id int primary key,
    name text
);

/*
 * Ingredient Table
 * contains all per-ingredient data
 */
create table ingredient
(
    id int primary key,
    name text,
    test_data boolean,
    unit_category int,
    foreign key (unit_category) references unit_category(id) on delete cascade
);

/*
 * Unit Table
 * helps perform various unit conversions within the application
 *
 * e.g.
 * 1 tbsp = 25 * 10^(-3) L 
 */
create table unit
(
    id int primary key,
    name_formal text,
    name_symbol text,
    value int,
    exponent int,
    unit_category int,
    main_unit boolean,
    foreign key (unit_category) references unit_category(id) on delete cascade
);

/*
 * User Ingredient Table
 * links a user and ingredient using a quantity
 */
create table user_ingredient
(
    user_id int,
    ingredient_id int,
    quantity numeric(9,3),
    primary key (user_id, ingredient_id),
    foreign key (user_id) references user_map(id) on delete cascade,
    foreign key (ingredient_id) references ingredient(id) on delete cascade
);

commit;

/* -------------------- END SCHEMA -------------------- */



/* -------------------- BEGIN UNITS -------------------- */

/* Unit Categories */
insert into unit_category
    (id, name)
values
    (1, 'volume'),
    (2, 'weight'),
    (3, 'unit');

/* Units - Volume */
insert into unit 
    (id, name_formal, name_symbol, value, exponent, unit_category, main_unit)
values
    (1, 'millilitre', 'mL', 1, -3, 1, false),
    (2, 'litre', 'L', 1, 1, 1, true),
    (3, 'cup', 'cup', 250, -3, 1, false),
    (4, 'teaspooon', 'tsp', 15, -3, 1, false),
    (5, 'tablespoon', 'tbsp', 25, -3, 1, false);

/* Units - Weight */
insert into unit 
    (id, name_formal, name_symbol, value, exponent, unit_category, main_unit)
values
    (6, 'gram', 'g', 1, 1, 2, true),
    (7, 'milligram', 'mg', 1, -3, 2, false),
    (8, 'kilogram', 'kg', 1, 3, 2, false);

/* Units - Unit */
insert into unit 
    (id, name_formal, name_symbol, value, exponent, unit_category, main_unit)
values
    (9, '', '', 1, 1, 3, true);

commit;

/* -------------------- ENG UNITS -------------------- */



/* -------------------- BEGIN TEST DATA -------------------- */

insert into ingredient
    (id, name, test_data, unit_category)
values
    (100, 'fd_carrot', true, 3),
    (101, 'fd_apple', true, 3),
    (102, 'fd_orange', true, 3);

insert into user_map
    (id, external_id)
values
    (1, '54aedb94e6c12b1c0e83385f'),
    (2, '544edb94e6c12b1c0e83355f'),
    (3, '566edb94e6c12b1c0e83366f');

insert into user_ingredient
    (user_id, ingredient_id, quantity)
values
    (1, 100, 5),
    (1, 101, 5),
    (2, 101, 5),
    (3, 102, 10);

commit;
/* -------------------- END TEST DATA -------------------- */
