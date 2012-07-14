// Initiate replica set: repl_b

config = 
{
    "_id" : "repl_b", "members" : [
        {"_id" : 1, "host" : "localhost:10005"},
        {"_id" : 2, "host" : "localhost:10006"},
        {"_id" : 3, "host" : "localhost:10007"}
     ]
};

rs.initiate(config);
