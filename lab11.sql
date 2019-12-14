select * from authors_and_artists$

update authors_and_artists$
set [Author Name]='Dr Theodor Seuss'
where [Author Name] like '%Seuss'


update authors_and_artists$
set [Book Name]='The Great Gatsby'
where [Book Name]='James Gatz'

update authors_and_artists$
set [Main Character]='James Gatz'
where [Main Character]='The Great Gatsby'

update authors_and_artists$
set [Favorite Artist]='Claude Monet'
where [Favorite Artist]='Claude MONET'

select * from authors_and_artists$

if exists 	(select * from  information_schema.table_constraints
	WHERE constraint_name='artists_style_artists')
ALTER TABLE artists_style DROP CONSTRAINT artists_style_artists;

if exists 	(select * from  information_schema.table_constraints
	WHERE constraint_name='artists_style_style')
ALTER TABLE artists_style DROP CONSTRAINT artists_style_style;

if exists 	(select * from  information_schema.table_constraints
	WHERE constraint_name='authors_artists')
ALTER TABLE authors DROP CONSTRAINT authors_artists;

if exists 	(select * from  information_schema.table_constraints
	WHERE constraint_name='books_authors')
ALTER TABLE books DROP CONSTRAINT books_authors;

if exists 	(select * from  information_schema.table_constraints
	WHERE constraint_name='books_publishers')
ALTER TABLE books DROP CONSTRAINT books_publishers;

if exists (select * from information_schema.tables 
	WHERE table_name='artists_style')
DROP TABLE artists_style;

if exists (select * from information_schema.tables 
	WHERE table_name='authors')
DROP TABLE authors;

if exists (select * from information_schema.tables 
	WHERE table_name='books')
	DROP TABLE books;

if exists (select * from information_schema.tables 
	WHERE table_name='artists')
DROP TABLE artists;

if exists (select * from information_schema.tables 
	WHERE table_name='publishers')
DROP TABLE publishers;

if exists (select * from information_schema.tables 
	WHERE table_name='style')
DROP TABLE style;

CREATE TABLE artists (
    artist_name varchar(100)  NOT NULL,
    city_of_origin varchar(100)  NOT NULL,
    country_of_orgin varchar(50)  NOT NULL,
    CONSTRAINT artists_pk PRIMARY KEY  (artist_name)
);

-- Table: artists_style
CREATE TABLE artists_style (
    artist_name varchar(100)  NOT NULL,
    type_of_art varchar(50)  NOT NULL,
    CONSTRAINT artists_style_pk PRIMARY KEY  (artist_name,type_of_art)
);

-- Table: authors
CREATE TABLE authors (
    author_id int identity(1,1)  NOT NULL,
    author_name varchar(100)  NOT NULL,
    favorite_artist varchar(100)  NOT NULL,
    CONSTRAINT authors_pk PRIMARY KEY  (author_id)
);

-- Table: books
CREATE TABLE books (
    book_id int identity(200,10)  NOT NULL,
    book_title varchar(100)  NOT NULL,
    main_character varchar(100)  NOT NULL,
    author_id int  NOT NULL,
    publisher_id int  NOT NULL,
    year_published int  NOT NULL,
    CONSTRAINT books_pk PRIMARY KEY  (book_id)
);

-- Table: publishers
CREATE TABLE publishers (
    publisher_id int identity(300,1) NOT NULL,
    publisher_name varchar(100)  NOT NULL,
    CONSTRAINT publishers_pk PRIMARY KEY  (publisher_id)
);

-- Table: style
CREATE TABLE style (
    type_of_art varchar(50)  NOT NULL,
    CONSTRAINT style_pk PRIMARY KEY  (type_of_art)
);

-- foreign keys
-- Reference: artists_style_artists (table: artists_style)
ALTER TABLE artists_style ADD CONSTRAINT artists_style_artists
    FOREIGN KEY (artist_name)
    REFERENCES artists (artist_name);

-- Reference: artists_style_style (table: artists_style)
ALTER TABLE artists_style ADD CONSTRAINT artists_style_style
    FOREIGN KEY (type_of_art)
    REFERENCES style (type_of_art);

-- Reference: authors_artists (table: authors)
ALTER TABLE authors ADD CONSTRAINT authors_artists
    FOREIGN KEY (favorite_artist)
    REFERENCES artists (artist_name);

-- Reference: books_authors (table: books)
ALTER TABLE books ADD CONSTRAINT books_authors
    FOREIGN KEY (author_id)
    REFERENCES authors (author_id);

-- Reference: books_publishers (table: books)
ALTER TABLE books ADD CONSTRAINT books_publishers
    FOREIGN KEY (publisher_id)
    REFERENCES publishers (publisher_id);

-- End of file.

insert into style
(type_of_art)
select distinct [Type of Art 1]
from authors_and_artists$
where [Type of Art 1] is not null
union
select distinct [Type of Art 2]
from authors_and_artists$
where [Type of Art 2] is not null
union
select distinct [Type of Art 3]
from authors_and_artists$
where [Type of Art 3] is not null
union
select distinct [Type of Art 4]
from authors_and_artists$
where [Type of Art 4] is not null
union
select distinct [Type of Art 5]
from authors_and_artists$
where [Type of Art 5] is not null

insert into publishers 
(publisher_name)
select distinct [Publisher Name]
from authors_and_artists$

insert into artists
(artist_name,city_of_origin,country_of_orgin)
select distinct [Favorite Artist],
left([Artist Origin],charindex(',',[Artist Origin])-1),
right([Artist Origin],len([Artist Origin]) - charindex(',',[Artist Origin]))
from authors_and_artists$

insert into authors
(author_name,favorite_artist)
select distinct [Author Name],[Favorite Artist]
from authors_and_artists$

insert into books
(book_title,main_character,author_id,publisher_id,year_published)
select [Book Name],[Main Character],authors.author_id,publishers.publisher_id,[Published]
from authors_and_artists$ full join authors on [Author Name] = authors.author_name
full join publishers on [Publisher Name] = publishers.publisher_name

insert into artists_style
(artist_name,type_of_art)
select distinct [Favorite Artist],([Type of Art 1])
from authors_and_artists$
where [Type of Art 1] is not null
union
select distinct [Favorite Artist],[Type of Art 2]
from authors_and_artists$
where [Type of Art 2] is not null
union
select distinct [Favorite Artist],[Type of Art 3]
from authors_and_artists$
where [Type of Art 3] is not null
union
select distinct [Favorite Artist],[Type of Art 4]
from authors_and_artists$
where [Type of Art 4] is not null
union
select distinct [Favorite Artist],[Type of Art 5]
from authors_and_artists$
where [Type of Art 5] is not null

select * from authors
select * from artists_style
select * from publishers
select * from style
select * from books
select * from artists

select authors.author_name,books.book_title,authors.favorite_artist,artists.country_of_orgin
from authors join books on authors.author_id = books.author_id
join artists on authors.favorite_artist = artists.artist_name
where artists.country_of_orgin like '%Spain%'
or artists.country_of_orgin like '%France%'

select  books.year_published,publishers.publisher_name,books.book_title
from books join publishers on books.publisher_id = publishers.publisher_id
where publishers.publisher_name like '%Harper%'
order by books.year_published desc

insert into style
(type_of_art)
values
('musician')

insert into artists_style
(artist_name,type_of_art)
values
('Claude Monet','musician')

select * from style
select * from artists_style