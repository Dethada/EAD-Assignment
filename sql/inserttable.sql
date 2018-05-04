insert into movie(title,releasedate,synopsis,duration,imagepath,status)
values ("Marvel Studio’ Avengers: Infinity War","2018-04-24","The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.","image/default.png",
"Now Showing"),
 ("Rampage","2018-04-12","Primatologist Davis Okoye (Johnson), a man who keeps people at a distance, shares an unshakable bond with George, the extraordinarily intelligent, silverback gorilla who has been in his care since birth. But a rogue genetic experiment gone awry mutates this gentle ape into a raging creature of enormous size. To make matters worse, it’s soon discovered there are other similarly altered animals. As these newly created alpha predators tear across North America, destroying everything in their path, Okoye teams with a discredited genetic engineer to secure an antidote, fighting his way through an ever-changing battlefield, not only to halt a global catastrophe but to save the fearsome creature that was once his friend."
 ,107,"image/default.png","Now Showing"),
("Deadpool 2","2018-05-17","After surviving a near fatal bovine attack, a disfigured cafeteria chef (Wade Wilson) struggles to fulfill his dream of becoming Mayberry's hottest bartender while also learning to cope with his lost sense of taste. Searching to regain his spice for life, as well as a flux capacitor, Wade must battle ninjas, the yakuza, and a pack of sexually aggressive canines, as he journeys around the world to discover the importance of family, friendship, and flavor - finding a new taste for adventure and earning the coveted coffee mug title of World's Best Lover.
",110,"image/default.png","Coming Soon"),
("Jurassic World: Fallen Kingdom","2018-06-07","It’s been four years since theme park and luxury resort Jurassic World was destroyed by dinosaurs out of containment. Isla Nublar now sits abandoned by humans while the surviving dinosaurs fend for themselves in the jungles.When the island’s dormant volcano begins roaring to life, Owen (Chris Pratt) and Claire (Bryce Dallas Howard) mount a campaign to rescue the remaining dinosaurs from this extinction-level event. Owen is driven to find Blue, his lead raptor who’s still missing in the wild, and Claire has grown a respect for these creatures she now makes her mission. Arriving on the unstable island as lava begins raining down, their expedition uncovers a conspiracy that could return our entire planet to a perilous order not seen since prehistoric times.",
120,"image/default.png","Coming soon")

insert into actor(Name,description)
values("Robert Downey Jr.","Robert Downey Jr. has evolved into one of the most respected actors in Hollywood. With an amazing list of credits to his name, he has managed to stay new and fresh even after over four decades in the business."),
("Chris Pratt","Christopher Michael Pratt is an American film and television actor. He came to prominence from his television roles and is well known for being the main character in  the sci-fi thriller Jurassic World (2015)."),
("Dwayne Johnson","Dwayne Douglas Johnson is an American actor, producer, singer, musician, and semi-retired professional wrestler. Johnson's first leading film role was in The Scorpion King in 2002. For this, he was paid US$5.5 million, a world record for an actor in his first starring role.[13] One of his more prominent roles is Luke Hobbs in The Fast and the Furious franchise."),
("Chris Evans", "Christopher Robert Evans is an American actor. Evans is known for his superhero roles as the Marvel Comics characters Captain America in the Marvel Cinematic Universe and Human Torch in Fantastic Four (2005) and its 2007 sequel."),
("Chris Hemsworth","Christopher Hemsworth (born,11 August 1983) is an Australian actor. He is known for playing Kim Hyde in the Australian TV series Home and Away (2004–07) and Thor in the Marvel Cinematic Universe since 2011.")

insert into MovieActor
values(1,1),
(1,2),
(1,4),
(2,3)

insert into Genre(name,description)
values("Action","Action film is a film genre in which the protagonist or protagonists are thrust into a series of challenges."),
("Romance","Romance films are romantic love stories that focus on passion, emotion, and the affectionate romantic involvement."),
("Thriller","hrillers are characterized and defined by the moods they elicit, giving viewers heightened feelings of suspense, excitement, surprise, anticipation and anxiety."),
("Comedy","Comedy is a genre of film in which the main emphasis is on humor. These films are designed to make the audience laugh through amusement."),
("Drama","Drama film is a genre that relies on the emotional and relational development of realistic characters. Often, these dramatic themes are taken from intense, real life issues.")

insert into users(username,password,role) values
("admin","admin","admin")

insert into timeslot values
("2018/04/27 08:00:00",1),
("2018/04/27 10:00:00",1),
("2018/04/27 12:00:00",1),
("2018/04/27 14:00:00",2)
