CREATE TABLE categories(
    id varchar(36) NOT NULL PRIMARY KEY,
    name text NOT NULL,
    description text,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now()
);

CREATE TABLE courses(
    id varchar(36) NOT NULL PRIMARY KEY,
    category_id varchar(36) NOT NULL,
    name text NOT NULL,
    description text,
    price decimal(10,2) NOT NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);