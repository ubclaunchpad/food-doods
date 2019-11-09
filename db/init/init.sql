create table ingredient
(
  ingredient_id serial primary key,
  name text,
  category text
);

create table id_map
(
  internal_id int unique not null,
  external_id int unique not null,
  primary key (internal_id, external_id)
);

create table stored_ingredient
(
  user_id int,
  ingredient_id int,
  primary key (user_id, ingredient_id),
  foreign key (user_id) references id_map(internal_id) on delete cascade,
  foreign key (ingredient_id) references ingredient(ingredient_id) on delete cascade
);

commit;

insert into ingredient
  (ingredient_id, name, category)
values
  (100, 'carrot', 'vegetable');

insert into ingredient
  (ingredient_id, name, category)
values
  (101, 'broccoli', 'vegetable');

insert into ingredient
  (ingredient_id, name, category)
values
  (102, 'apple', 'fruit');

insert into id_map
values
  (1, 300);

insert into id_map
values
  (2, 301);

insert into id_map
values
  (3, 302);

insert into stored_ingredient
values
  (1, 100);

insert into stored_ingredient
values
  (1, 101);

commit;
