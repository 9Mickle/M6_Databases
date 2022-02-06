---------GIN----------
create extension pg_trgm; 

Create INDEX idx_surname
On student Using GIN(surname gin_trgm_ops);

Create INDEX idx_name
On student Using GIN(name gin_trgm_ops);


---------GIST----------
Create INDEX idx_surname
On student Using GIST(surname gist_trgm_ops);

Create INDEX idx_name
On student Using GIST(name gist_trgm_ops);


---------B-Tree----------
Create INDEX idx_surname
On student Using btree(surname);

Create INDEX idx_name
On student Using btree(name);

Create INDEX idx_phone
On student Using btree(phone_number);


---------HASH----------
Create INDEX idx_surname
On student Using HASH(surname);

Create INDEX idx_name
On student Using HASH(name);

Create INDEX idx_phone
On student Using HASH(phone_number);