// Initiate replica set: repl_a

// Our initial test data goes here as well !

config = 
{
    "_id" : "repl_a", "members" : [
        {"_id" : 1, "host" : "localhost:10000"},
        {"_id" : 2, "host" : "localhost:10001"},
        {"_id" : 3, "host" : "localhost:10002"}
     ]
};

rs.initiate(config);

print("Sleeping for 60 seconds to give replica set repl_a time to come up...");
print("(We can't save data there until it has!)");

sleep(60000);

print("Building our test collection...");

for (var i = 0; i<=100000; i++) {
    db.users.save(
    {
        name : 'Mr Smith',
        fave_number : i
    }
    );
}

db.users.ensureIndex( { fave_number : 1} );
