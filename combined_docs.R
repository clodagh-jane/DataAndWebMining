library('rvest')

url <- 'https://www.nytimes.com/interactive/2020/books/notable-books.html'

webpage <- read_html(url)
webpage 

##Book Title
title_data_html <- html_nodes(webpage, '.g-book-data a')
#Converting the horse name to text
title_data <- html_text(title_data_html)
head(title_data)
title_data
title_data<-gsub("\n ","",title_data)

bad_words <- c("Amazon", "Local Booksellers", "Barnes and Noble") # Write all the words you want removed here!
bad_regex <- paste(bad_words, collapse = "|")
title_data <- trimws( sub(bad_regex,"", title_data) )

#remove blanks
title_data <- title_data[title_data != ""]

##Author
author_data_html <- html_nodes(webpage, 'b')
#Converting the horse name to text
author_data <- html_text(author_data_html)
##Convert to  factor
head(author_data)

#book description 
description_data_html <- html_nodes(webpage, '.g-book-description')
#Converting the horse name to text
description_data <- html_text(description_data_html)

head(description_data)
#Removing anything after & symbol
description_data<-gsub("\n","",description_data)
#removing spaces
#Converting genre to a factor
##description_data<-gsub(" ","",description_data)

##Genre 
genre_data_html <- html_nodes(webpage, '.g-book-tag:nth-child(1)')
#Converting the horse name to text
genre_data <- html_text(genre_data_html)
head(genre_data)

#Removing anything after & symbol
genre_data<-gsub("\n","",genre_data)
#Removing spaces
genre_data<-gsub(" ","",genre_data)
#Converting genre to a factor
head(genre_data)

##Creating data frame for all the data
books_df = data.frame( Title = title_data, Author = author_data, Genre = genre_data, Description = description_data)
write.csv(books_df,"book.csv", row.names = FALSE)

str(books_df)

#######################################################################################
########################## WEB 2

url2 <- 'https://www.goodreads.com/list/show/143444.Best_books_of_2020'

webpage2 <- read_html(url2)
webpage2 

##Book Title
title_data_html2 <- html_nodes(webpage2, '.bookTitle span')
#Converting the horse name to text
title_data2 <- html_text(title_data_html2)
head(title_data2)

##Book Rank
rank_data_html2 <- html_nodes(webpage2, '.number')
#Converting the horse name to text
rank_data2 <- html_text(rank_data_html2)
head(rank_data2)

##Author
author_data_html2 <- html_nodes(webpage2, '.authorName span')
#Converting the horse name to text
author_data2 <- html_text(author_data_html2)

##Convert to  factor
head(author_data2)

##Creating data frame for all the data
books_df2 = data.frame( Title = title_data2, Author = author_data2, Rank = rank_data2)


str(books_df2)

#######################################################################################
##################################WEBSITE 3###########################################
url3 <- 'https://www.theguardian.com/news/datablog/2012/aug/09/best-selling-books-all-time-fifty-shades-grey-compare'

webpage3 <- read_html(url3)
webpage3 

##Book Title
title_data_html3 <- html_nodes(webpage3, 'td:nth-child(2)')
#Converting the horse name to text
title_data3 <- html_text(title_data_html3)

head(title_data3)

##Author
author_data_html3 <- html_nodes(webpage3, 'td:nth-child(3)')
#Converting the horse name to text
author_data3 <- html_text(author_data_html3)
##Convert to  factor


head(author_data3)


#Publisher
publisher_data_html3 <- html_nodes(webpage3, 'td:nth-child(5)')
#Converting the horse name to text
publisher_data3 <- html_text(publisher_data_html3)
## Convert to factor


head(publisher_data)

##Genre
genre_data_html3 <- html_nodes(webpage3, 'td:nth-child(6)')
#Converting the horse name to text
genre_data3 <- html_text(genre_data_html3)
#Reducing to one genre
genre_data3<-gsub(" ","",genre_data3)

#taking only the first genre of each movie
genre_data3<-gsub(",.*","",genre_data3)
#Removing anything after & symbol
genre_data3<-gsub("&.*","",genre_data3)
#Converting genre to a factor


head(genre_data3)

##Creating data frame for all the data
books_df3 = data.frame( Title = title_data, Author = author_data, Publisher = publisher_data, Genre = genre_data)


str(books_df3)


library(ggplot2)
qplot(data=books_df3,Sales, fill = Genre)

plot(data= books_df3, x=sales_data, y=genre_data)


##Creating the corpus
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ------------------------------------------------------------------------
doc1 <-  "Title, The Aosawa Murders, The Beauty in Breaking A Memoir, The Beauty of Your Face, Becoming Wild How Animal Cultures Raise Families Create Beauty and Achieve Peace, Beheld, The Biggest Bluff How I Learned to Pay Attention Master Myself and Win, Black Wave Saudi Arabia Iran and the Forty-Year Rivalry That Unraveled Culture Religion and Collective Memory in the Middle East, Blacktop Wasteland, The Book of Eels Our Enduring Fascination With the Most Mysterious Creature in the Natural World, The Boy In The Field, Breasts and Eggs, A Burning, Burning Down the House Newt Gingrich the Fall of a Speaker and the Rise of the New Republican Party, Caste The Origins of our Discontents, A Childrens Bible, Cleanness, Deacon King Kong, The Dead Are Arising The Life of Malcolm X, The Death of Jesus, The Death of Vivek Oji, Deaths of Despair and the Future of Capitalis, Desert Notebooks A Road Map for the End of Time, Djinn Patrol on the Purple Line, A Dominant Character The Radical Science and Restless Politics of J B S Haldane, The Dragons the Giant the Women A Memoir, The Duke Who Didnt, Earthlings, Eat the Buddha Life and Death in a Tibetan Town, The End of Everything (Astrophysically Speaking), Everywhere You Dont Belong, Exercise of Power American Failures Successes and a New Path Forward in the Post-Cold War World, Fallout The Hiroshima Cover-Up and the Reporter Who Revealed It to the World, Feed, Felon Poems, The Glass Kingdom, The Hardhat Riot Nixon New York City and the Dawn of the White Working-Class Revolution, Hamnet, Hidden Valley Road Inside the Mind of an American Family, His Only Wife, Homeland Elegies, How Much of These Hills Is Gold, Hurricane Season, The Inevitability of Tragedy Henry Kissinger and His World, Jack, Just Us An American Conversation, Kim Jiyoung Born 1982, The King at the Edge of the World, Little Eyes, The Loneliness of the Long-Distance Cartoonist, Luster, Man of My Time, The Man Who Ran Washington The Life and Times of James A Baker III, Memorial, Memorial Drive A Memoir, The Memory Monster, The Mercies, Minor Detail, The Mirror & the Light, Missionaries, Monogamy, 97196 Words Essays,Notes on a Silencing A Memoir, Obit Poems, Overground Railroad The Green Book and the Roots of Black Travel in America, Owls of the Eastern Ice A Quest to Find and Save the World‚ Aos Largest Owl, A Peculiar Indifference The Neglected Toll of Violence on Black America, A Pilgrimage to Eternity From Canterbury to Rome in Search of a Faith, A Promised Land, The Quiet Americans Four CIA Spies at the Dawn of the Cold War ‚Äî a Tragedy in Three Acts, Reaganland America‚Äôs Right Turn 1976-1980, Real Life, Red Pill, The Saddest Words William Faulkner‚Äôs Civil War, Saint X, Sea Wife, The Selected Letters of Ralph Ellison, Shakespeare in a Divided America What His Plays Tell Us About Our Past and Future, Sharks in the Time of Saviors, Shuggie Bain, The Sirens of Mars Searching for Life on Another World, Sisters, Soul Full of Coal Dust A Fight for Breath and Justice in Appalachia, The Splendid and the Vile A Saga of Churchill Family and Defiance During the Blitz, The Third Rainbow Girl The Long Life of a Double Murder in Appalachia, This Is All I Got A New Mother‚Äôs Search for Home, Tokyo Ueno Station, The Tunnel, Uncanny Valley A Memoir, The Undocumented Americans, Until the End of Time Mind Matter and Our Search for Meaning in an Evolving Universe, The Vanishing Half, The Vapors A Southern Family the New York Mob and the Rise and Fall of Hot Springs America‚Äôs Forgotten Capital of Vice, Wagnerism Art and Politics in the Shadow of Music, War How Conflict Shaped Us, The Weirdest People in the World How the West Became Psychologically Peculiar and Particularly Prosperous, Who Gets in and Why A Year Inside College Admissions, Why I Don't Write And Other Stories, A Woman Like Her The Story Behind the Honor Killing of a Social Media Star, Writers and Lovers, Yellow Bird Oil Murder and a Woman Aos Search for Justice in Indian Country"

doc2 <-"Riku Onda, Michele Harper, Sahar Mustafah, Carl Safina, TaraShea Nesbit, Maria Konnikova, Kim Ghattas, S A Cos, Patrik Svensson, Margot Livesey, Mieko Kawakami, Megha Majumdar, Julian E, Zelizer, Isabel Wilkerson, Lydia Millet, Garth Greenwell, James McBride, Les Payne and Tamara Payne, J, M, Coetzee, Akwaeke Emezi, Anne Case and Angus Deaton, Ben Ehrenreich, Deepa Anappara, Samanth Subramanian, Waytu Moore, Courtney Milan, Sayaka Murata, Barbara Demick, Katie Mack, Gabriel Bump, Robert M, Gates, Lesley M M Blume, Tommy Pico, Reginald Dwayne Betts, Lawrence Osborne, David Paul Kuhn, Maggie OFarrell, Robert Kolker, Peace Adzo Medie, Ayad Akhtar, C Pam Zhang, Fernanda Melchor, Barry Gewen, Marilynne Robinson, Claudia Rankine, Cho Nam-Joo, Arthur Phillips, Samanta Schweblin, Adrian Tomine, Raven Leilani, Dalia Sofer, Peter Baker and Susan Glasser, Bryan Washington, Natasha Trethewey, Yishai Sarid, Kiran Millwood Hargrave, Adania Shibli, Hilary Mantel, Phil Klay, Sue Miller, Emmanuel Carrvre, Lacy Crawford, Victoria Chang,  Candacy Taylor, Jonathan C, Slaght, Elliott Currie, Timothy Egan, Barack Obama, Scott Anderson, Rick Perlstein, Brandon Taylor, Hari Kunzru, Michael Gorra, Alexis Schaitkin, Amity Gaige, Edited  John F, Callahan and Marc C, Conner, James Shapiro, Kawai Strong Washburn, Douglas Stuart, Sarah Stewart Johnson, Daisy Johnson, Chris Ham, Erik Larson, Emma Copley Eisenberg, Lauren Sandler, Yu Miri, A B Yehoshu, Anna Wiener, Karla Cornejo Villavicencio, Brian Greene, Brit Bennett, David Hill, Alex Ross, Margaret MacMillan, Joseph Henrich, Jeffrey Selingo, Susan Minot, Sanam Maher, Lily King, Sierra Crane Murdoch"

doc3 <-  "Fiction, Nonfiction, Fiction, Nonfiction, Fiction, Nonfiction, Nonfiction, Fiction, Nonfiction, Fiction, Fiction, Fiction, Nonfiction, Nonfiction, Fiction, Fiction, Fiction, Nonfiction, Fiction, Fiction, Nonfiction, Nonfiction, Fiction, Nonfiction, Nonfiction, Fiction, Fiction, Nonfiction, Nonfiction, Fiction, Nonfiction, Nonfiction, Poetry, Poetry, Fiction, Nonfiction, Fiction, Nonfiction, Fiction, Fiction, Fiction, Fiction, Nonfiction, Fiction, Nonfiction, Fiction, Fiction, Fiction, Nonfiction, Fiction, Fiction, Nonfiction, Fiction, Nonfiction, Fiction, Fiction, Fiction, Fiction, Fiction, Fiction, Nonfiction, Nonfiction, Poetry, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Fiction, Fiction, Nonfiction, Fiction, Fiction, Nonfiction, Nonfiction, Fiction, Fiction, Nonfiction, Fiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Fiction, Fiction, Nonfiction, Nonfiction, Nonfiction, Fiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Nonfiction, Fiction, Nonfiction, Fiction, Nonfiction"

doc4 <- "Onda  as strange engrossing novel    patched together from scraps of interviews letters newspaper articles and the like    explores the sweltering day that 17 members of the Aosawa family died after drinking poisoned sake and soda,            
     When Harper was a teenager she drove her brother to the hospital to get treated for a bite her father had inflicted There she glimpsed a world she wanted to join   The Beauty in Breaking   is her memoir of becoming an emergency room physician It  as also a profound statement on the inequities in medical care today,            
     In the Chicago suburbs a gunman opens fire at a school for Palestinian girls Mustafah rewinds from the shooting to the principal  as childhood as a newly arrived immigrant Hers is a story of outsiders coming together in surprising and uplifting ways,           
     Safina the ecologist and author of many books about animal behavior here delves into the world of chimpanzees sperm whales and macaws to make a convincing argument that animals learn from one another and pass down culture in a way that will feel very familiar to us,            
     In this plain spoken and lovingly detailed historical novel the story of the Mayflower Pilgrims and Plymouth Colony is refracted through the prism of female characters Despite the novel  as quietness of telling its currency is the human capacity for cruelty and subjugation of pretty much everyone by pretty much everyone,            
     Konnikova a writer for The New Yorker with a PhD in psychology decided to study poker for its interplay between luck and determination This is an account of her journey which took her much further into the world of high stakes gambling than she ever imagined,            
     A Lebanese born journalist and scholar takes a sweeping look at the unrest in the Middle East arguing that much of it is the result of the competition between Saudi Arabia and Iran,           
     In this gritty thriller set in rural Virginia Beauregard   Bug   Montage    the owner of a struggling auto shop    is drifting back into his old life of crime Cosby has a talent for well tuned action raising our heart rates and filling our nostrils with odors of gun smoke and burned rubber,            
     Svensson follows those slithery beings in every direction they take him producing a book that moves from Aristotle to Freud to the fishing trips of his youth            
     In Livesey  as exquisite new novel three siblings on their way home from school find a boy who has been attacked and left for dead in a field This discovery leads to a mystery that will change the lives of all involved            
     In supple and casual prose this celebrated Japanese novelist follows sisters in Osaka who are considering breast augmentation and sperm donation causing two generations of women to reckon with the realities of their physical bodies and the pressures put on them by society,            
     A brazen act of terrorism in an Indian metropolis sets the plot of this propulsive debut novel in motion and lands an innocent young bystander in jail With impressive assurance and insight Majumdar unfolds a timely story about the ways power is wielded to manipulate and crush the powerless,            
     As Zelizer recounts Gingrich brought a new slash and burn style to Congress in the late 1980s that disrupted old ways and led to repeated Republican successes,            
     The Pulitzer winning author advances a sweeping argument for regarding American racial bias through the lens of caste Drawing analogies with the social orders of modern India and Nazi Germany she frames barriers to equality in a provocative new light,            
     This superb novel begins as a generational comedy    a pack of kids and their middle aged parents coexist in a summer share   and turns steadily darker as climate collapse and societal breakdown encroach But Millet  as light touch never falters  in this time of great upheaval she implies our foundational myths take on new meaning and hope,            
     Greenwell  as narrator is a gay American teacher in Sofia Bulgaria who has a series of encounters that are sexually frank and psychologically complicated  the book achieves an unusual depth of accuracy about both physical activity and emotional undercurrent,            
     At the center of this raucous novel by the National Book Award winning author of   The Good Lord Bird   are a hard drinking church deacon and a sudden inexplicable act of violence But that qs just one strand of McBride  as tour de force a book resounding with madcap characters and sly commentary on race crime and inequality,            
     Thirty years in the making and encompassing hundreds of original interviews this magisterial biography of Malcolm X was completed by Les Payne  as daughter after his death in 2018 Its strengths lie in its finely shaded penetrating portrait of the Black activist and thinker whose legacy continues to find fresh resonance today,            
     With the pared down quality of a fable the final novel in Coetzee  as Jesus trilogy makes a case for the fantastical worldview of Don Quixote Young David enters an orphanage finds followers and imparts wisdom before falling terminally ill    a Christ figure sure but not one with easy or predictable parallels,            
     This steamroller of a story about coming of age and coming out in Nigeria centers on what a family doesn  at see    or doesn  at want to see    and whether that blindness contributes to a son  as death,            
     This highly important book examines the pain and despair among white blue collar workers and suggests that the hopelessness they are experiencing may eventually extend to the entire American work force,            
     The author a columnist for The Nation divides his book into two strands a journal like description of his life in desert America in a cabin near Joshua Tree National Park and his move to Las Vegas where his world shrinks Months into lockdown it feels creepily prescient We are all in the desert now,            
     This first novel by an Indian journalist probes the secrets of a big city shantytown as a 9 year old boy tries to solve the mystery of a classmate  as disappearance Anappara impressively inhabits the inner worlds of children lost to their families and of others who escape by a thread,            
     Haldane the British biologist and ardent communist who helped synthesize Darwinian evolution with Mendelian genetics was once as famous as Einstein Subramanian  as elegant biography doubles as a timely allegory of the fraught relationship between science and politics,           
     Following her magical realist debut novel   She Would Be King   Moore  as immersive exhilarating memoir also has elements of the fantastical    framed by her family  as harrowing escape from civil war in Liberia,            
     By turns consciously tender and fiercely witty this is an unalloyed charmer about Chloe Fong a stubborn Chinese British sauce maker and Jeremy Yu the half Chinese Duke of Lansing who  as head over heels for her but can  at seem to say so            
     In the Japanese author's second novel two cousins agree that they're aliens abandoned at birth among humans After the traumas of childhood in adulthood they seek to abandon society    aka the Baby Factory    altogether in favor of a moral vacuum,
     Demick tells a decades long story about Ngaba a small Sichuan town that has become the center of resistance to Chinese authority Lately this activism has taken the form of self immolation    an act of desperation as Demick  as panoramic reporting comprehensively shows,            
     Many books have been written about the creation of the universe 138 billion years ago But Mack a theoretical cosmologist is interested in how it all ends She guides us along a cosmic timeline studded with scientific esoterica and mystery,            
     It  as the rare book that can achieve an appropriate balance between heaviness and levity This debut novel    a comically dark coming of age story about growing up on the South Side of Chicago    pulls the feat off not just generously but seemingly without effort,            
     With decades of experience at the highest levels of government Gates presents a critique of past mistakes in American foreign policy and provides a guide for policymakers in the future,            
     For months after the bombing of Hiroshima and Nagasaki Americans were told little about the devastating effects on survivors Blume  as magisterial account of how John Hersey broke the story in The New Yorker is also a warning about the ever present dangers of nuclear war,            
     The title of Pico  as restless intimate and exhilarating new volume of poetry his fourth covers varieties of appetite for sex for nutrition for fame for news for gossip for simple companionship   Feed   lets sympathetic readers pretend to live for almost 80 pages inside Pico  as charismatic uneasy mind,            
     Betts  as searing third collection surveys the underworlds of incarceration and its aftermath   There is no name for this thing that you  ave become   he writes   Convict prisoner inmate lifer yardbird all fail   What does not fail is the language Betts sends prismatically through his experience to refract the prison industrial complex,            
     An American woman is on the lam with a suitcase full of cash in Osborne  as latest novel which is set in a Bangkok rattled by monsoons and social unrest As chaos grows her refuge a modern apartment complex grows more prisonlike Osborne  as command of mood keeps the reader  as pulse racing,            
     Kuhn highlights one day May 8 1970 when blue collar workers went on a rampage against antiwar protesters noting that the country  as politics have never been the same,            
     Shakespeare  as son Hamnet died at 11 a few years before the playwright wrote   Hamlet   O  aFarrell  as wondrous new novel is at once an unsparingly eloquent record of love and grief and a vivid imagining of how a child  as death was transfigured into art,            
     It reads like a Greek tragedy Six of the Galvins  a 12 children developed schizophrenia This book is much more than a narrative of despair though  its most compelling chapters involve the scientists who studied the family looking for genetic clues about the origins of this unfathomable disease,            
     This rich rewarding debut novel follows a Ghanaian seamstress    forced into an arranged marriage with a wealthy man she has never met    on her journey of self discovery   It wasn  at easy   she declares   being the key to other people  as happiness their victory and their vindication,              
     The latest novel from Akhtar is about the dream of national belonging that has receded for American Muslims in the years since 9/11 At once deeply personal and unreservedly political the book often reads like a collection of essays illustrating the author  as prismatic identity,            
     Zhang  as mesmerizing tale of two Chinese American siblings crossing the West during the gold rush with their father  as corpse in tow unfolds in a landscape of desolation and struggle that recalls Steinbeck and Faulkner and in a voice that is all her own,            
     This searing novel the first in English by the Mexican Melchor dazzles with fury and beauty Inspired by the wave of gruesome femicides in her home state of Veracruz the author transposes the violence directed at women to the register of fable,            
     In this magisterial account Gewen a longtime editor at the Book Review traces the historical and philosophical roots of Kissinger  as famous realism situating him in the context of Hannah Arendt and a cohort of other Jewish intellectuals who escaped Nazi Germany,            
     This uplifting addition to Robinson  as numinous Gilead series centers on an interracial romance in postwar St Louis that was hinted at but not amplified in the three books that preceded it The lovers Jack and Della find hope and truth in each other even as the world conspires to keep them apart,            
     As she did in her acclaimed 2014 collection   Citizen   Rankine here combines essays poetry and visual art to interrogate the ways race haunts her imagination and America  as   Fantasies cost lives   she writes,            
     A sensation when it appeared in South Korea in 2016 this novel recounts in the dispassionate language of a case history the descent into madness of a young wife and mother    a Korean Everywoman whose plight illuminates the effects of a sexist society,            
     Intrigue and espionage fuel this delectable novel set during the twilight of the reign of Elizabeth I and featuring a Muslim Ottoman physician who is enlisted in the machinations surrounding the choice of the queen  as successor,            
     In this brilliantly creepy novel surveillance takes the form of a toylike camera equipped pet that becomes a global sensation Owning one is like inviting a mute stranger into your home,            
     Tomine now considered a master of the graphic novel form returns in an autobiographical mode in a book that lets vent the rage and fragility that are always just beneath the surface of his pristine drawings,            
     This first novel    about a 23 year old New Yorker who becomes entangled with a white suburban couple and their Black daughter    feels like summer sentences like ice that crackle or melt into a languorous drip  plot suddenly wildly flying forward like a bike down a hill,             
     Sofer  as second novel traces a man  as path from   baffled revolutionary   in Iran to complicit actor in a ruthless regime sure he can undermine the system from inside It is a master class in layering together a character who is essentially unforgivable but no less captivating,            
     This fascinating biography of the former secretary of state and consummate insider who was once called   the most important unelected official since World War II   reveals both Baker  as accomplishments and the compromises he had to make,             
     A sense of estrangement pervades this assured debut novel which opens as a man flies to Osaka to care for his terminally ill father leaving his visiting mother and his Black boyfriend to keep each other company One of the great themes of   Memorial   is the immense power parents wield over their children even well into adulthood,            
     At the center of Trethewey  as memoir is the wrenching story of her mother  as murder by her ex husband in 1985 But this haunting elegy by the Pulitzer Prize winning poet is also a work of great beauty and tenderness an atmospheric evocation of innocence and loss,             
     This brilliant short novel serves as a brave sharp toothed brief against letting the past devour the present Sarid tells the story of a tour guide to the Nazi death camps and how his mind begins to slowly unravel as his knowledge of the mechanics of genocide becomes an obsession,             
     This unsparing beautifully written novel takes as its subject the Vardo witch trials in 17th century Norway which even the infamous hysteria in Salem Mass several decades later could not match when it came to brutality For such a book to center on a cast of powerful women characters seems as appropriate to its historical context as it is to our time,             
     This slim haunting novel begins with the rape and murder of a Palestinian girl in 1949 then shifts to present day Ramallah where a young woman tries to piece together what happened Shibli turns her astonishing command of sensory detail into a rich study of memory and violence,              
     The final novel in Mantel  as   Wolf Hall   trilogy returns to the terror of Henry VIII  as court where falls from grace are sudden and frequently fatal For all its political and literary plotting the book is most memorable for its portraiture with Henry  as secretary Thomas Cromwell as our master painter,             
     The four converging narratives of this astounding novel (Klay  as first after his National Book Award winning story collection   Redeployment  ) capture the complexities of Colombia  as five decade war Klay does not shy away from the thorny moral questions and psychological impacts of conflict and the result is at once terrifying and thought provoking,             
     A gregarious bookstore owner dies suddenly leaving his widow children and ex wife to make sense of the messy and colorful life they shared together Sue Miller  as engrossing novel is infused with generosity and the complicated kind of love readers will recognize from real life            
     This collection of short pieces by an author widely considered to be France  as leading nonfiction writer underscores Carr√®re  as incisive style and moral stance  whether he  as writing about a murderer or a movie star he is also investigating himself part of a deeply empathetic quest to understand our species,             
     This devastating and erudite memoir chronicles the author  as experience of sexual assault while she was a student at St Paul  as an elite boarding school in Concord NH    followed by a decades long cover up at the hands of an esteemed institution with money power and connections and her own complicated journey of recovery,             
     Chang  as new collection explores her father  as illness and her mother  as death treating mortality as a constantly shifting enigma A serene acceptance of grief emerges from these poems,            
     Taylor a cultural documentarian traveled to thousands of sites mentioned in the Green Book the essential guidebook for Black travelers braving American roads during Jim Crow Highlighting threats such travelers faced her lively illustrated history is mindful of the ongoing struggle for Black social mobility today,            
     Slaght is a wildlife biologist with a singular mission to conserve an elusive and enormous raptor in the eastern wilds of Russia The book is an ode to the rigors and pleasures of fieldwork in hard conditions,            
     This essential book by a veteran legal scholar argues that the extraordinary violence against Black lives is a result of the nation  as refusal to address the structural roots of the problem,            
     In his ninth book this self described   lapsed but listening   Irish Catholic travels 1200 miles from Canterbury to Rome along the Via Francigena and tries to decide what he believes If this book doesn  at settle the question it will at least fortify faith in scrupulous reporting and captivating storytelling,            
     The former president  as memoir    the first of two volumes    is a pleasure to read the prose gorgeous the detail granular and vivid From Southeast Asia to a forgotten school in South Carolina he evokes the sense of place with a light but sure hand His focus is more political than personal but when he does write about his family it is with a beauty close to nostalgia,            
     Covering the years 1944 to 1956 Anderson  as enthralling history of the early years of the Cold War follows four CIA operatives as their initial idealism eventually turns into betrayal and disillusionment fueled by creeping right wing hysteria at home and cynical maneuvering abroad,            
     More than a book about Ronald Reagan the conclusion of Perlstein  as four volume saga on the rise of conservatism in America is absorbing political and social history with sharp insights into the human quirks and foibles that were so much a part of the late 1970s,            
     In this stunning debut novel a gay Black graduate student from the South mines hope for some better or different life while he studies biochemistry in the haunted halls of a white academic space As in the modernist novels of Woolf and Tolstoy cited throughout the true action of Taylor  as novel exists beneath the surface,            
     A fellowship at a study center in Germany turns sinister and sets a writer on a possibly paranoid quest to expose a political evil he believes is loose in the world Kunzru  as wonderfully weird novel traces a lineage from German Romanticism to National Socialism to the alt right and is rich with insights on surveillance and power,            
     Gorra  as complex and thought provoking meditation on Faulkner is rich in insight making the case for the novelist  as literary achievement and his historical value    as an unparalleled chronicler of slavery  as aftermath and its damage to America  as psyche,            
     In 1995 on a nameless Caribbean island the daughter of an American family goes missing This debut novel is hypnotic delivering acute social commentary on everything from class and race to familial bonds and community and yet its weblike nature never confuses or fails to captivate,            
     A husband and wife try to escape their problems by packing up their small children and taking to the open sea on a boat they barely know how to sail Trouble follows but not necessarily the kind you  are expecting Gaige  as novel gives readers plenty to discuss including ethical dilemmas complicated family dynamics and the nature of forgiveness,            
     In his lifetime Ellison  as only novel was the masterpiece   Invisible Man   but for six decades he corresponded with some of the greatest writers of his day This magnificent collection captures his wit style ambition and personal travails as well as his powerful insights into Black artistic expression,            
     Shapiro has long created Shakespeare treats for the common reader but this time he outdoes himself From John Quincy Adams  as racist attacks on   Othello   to the notorious Trump as Julius Caesar Central Park production in 2017 he reminds us how divided we  ave been since our very beginnings with the historical tragical constantly muscling out the pastoral comical,            
     Washburn has no interest in the Hawaii of resorts and honeymoons  the characters in his singular debut novel live in a modern yet mystical version of the archipelago one whose essence no conqueror can ever fully eradicate,            
     Young Shuggie grows up in 1980s Glasgow with a calamitous alcoholic mother and punishing reminders that his effeminate manner sets him apart from his peers Pain    physical and emotional    is everywhere in this potent sure footed debut which makes as strong a case as any for love  as redemptive power,            
     Johnson a Georgetown planetary scientist oscillates between a history of Mars science and an account of her own journey seeking sparks of life in the immensity In prose that swirls with lyrical wonder she recalls formative moments in her life and career,            
     Secluded in a dilapidated country house their depressed mother in a room upstairs the teenage siblings at the center of this hypnotically macabre novel mull a sinister deed from their past Johnson expertly layers the Gothic atmosphere with dread grief and guilt,            
     Hamby powerfully recounts two stories both miserable the effect that working in coal mines has had on the health of miners and the decades long battle for federal help to force companies to pay for their medical care,            
     Larson  as account of Winston Churchill  as leadership during the 12 turbulent months from May 1940 to May 1941 when Britain stood alone and on the brink of defeat is fresh fast and deeply moving,            
     Decades after two young women were murdered there a small town continues to grapple with the crime This evocative and elegantly paced examination of the murders takes a prism like view,            
     In 2015 Sandler was volunteering at a homeless shelter when she met Camila a pregnant resident who was determined to find a permanent safe place to raise her child This book charts her path through red tape educational challenges family crises and moments of joy amid unimaginable struggle,            
     Yu  as glorious modernist novel is narrated by a voice from the dead a construction worker doomed to haunt various landmarks near Tokyo  as Ueno Park,            
     In this novel Zvi Luria a retired engineer in Tel Aviv is in the early stages of dementia and takes a job in the desert to keep his mind sharp The project involves building a road through an area where a Palestinian family lives hiding out amid ancient ruins Yehoshua masterfully entwines social commentary with a portrait of a mind in decline,            
     At 25 Wiener left a low paying publishing job and wound up in San Francisco in the hypercompetitive male dominated morally obtuse world of tech start ups Her splendid memoir stylish and unsparing is a vital reckoning with an industry awash in self delusion,            
     Cornejo Villavicencio was one of the first undocumented students to be accepted into Harvard University In her captivating and evocative first book she tells   the full story   of what that means    relying not just on her own experience but on interviews with immigrants across the country,            
     Few humans share Greene  as mastery of both the latest cosmological science and English prose Here the best selling physicist takes on our deepest mysteries consciousness creativity and the end of time            
     Bennett  as gorgeously written second novel an ambitious meditation on race and identity considers the divergent fates of twin sisters born in the Jim Crow South after one decides to pass for white Bennett balances the literary demands of dynamic characterization with the historical and social realities of her subject matter,            
     Hill grew up in Hot Springs Ark decades after its 20th century heyday as the boozy freewheeling hangout of choice for gamblers mobsters and crooked politicians  his book recreates the giddy era with a delightfully light touch and a focus on the nightclub of the title,            
     With enormous intellectual range and subtle artistic judgment Ross  as history of ideas probes the nerve endings of Western society as they are mirrored in more than a century of reaction to Richard Wagner  as oeuvre from George Eliot to   Apocalypse Now,              
     This is a short book but a rich one with a profound theme MacMillan argues that war fighting and killing is so intimately bound up with what it means to be human that viewing it as an aberration misses the point War has led to many of civilization  as great disasters but also to many of civilization  as greatest achievements,            
     Henrich combines evidence from his own lab with the work of dozens of collaborators across multiple fields to make an ambitious case for the distinctiveness of Western psychology,            
     Selingo challenges the facade of meritocracy in his absorbing examination of America  as obsession with getting into college Schools he argues persuasively are looking out for their own interests not yours,            
     The stories in this collection Minot  as first since 1989 are concerned with love death estrangement loss and memory which means that they are concerned with time itself,            
     This fascinating portrait of Qandeel Baloch Pakistan  as first big female internet sensation is also a skillfully reported account of a country in which conservative mores conflict with the pace of social change and in which women all too often pay the price,            
     A former golf prodigy turned waiter and writer is lonely broke directionless and grieving for her mother who has died suddenly King  as hopeful novel follows this young woman  as hardscrabble quest for solvency peace and passion,            
     This painstakingly reported and beautifully written book Murdoch  as first examines the effects of fracking on a North Dakota reservation through the eyes of a remarkable Native American woman who determined to solve a murder related to the oil boom exposes the greed and corruption that fueled it"

#remove \n from doc 4
doc4<-gsub("\n","",doc4)

## ------------------------------------------------------------------------
doc5 <- "House of Earth and Blood (Crescent City, #1), American Dirt, The House in the Cerulean Sea, ?????????? ???????? , The Vanishing Half, Beach Read, The Invisible Life of Addie LaRue, My Dark Vanessa, The Midnight Library, Chain of Gold (The Last Hours, #1), Dear Edward, Reign (The Sainthood - Boys of Lowell High, #3), Mexican Gothic, Rebellion (The Sainthood - Boys of Lowell High, #2), The Ballad of Songbirds and Snakes (The Hunger Games, #0), Resurrection (The Sainthood - Boys of Lowell High, #1), The Sun Down Motel, The Guest List, Untamed, The Present (VanWest, #2), Long Bright River, The Past (VanWest, #1), The Girl with the Louding Voice, The Southern Book Club's Guide to Slaying Vampires, In Five Years, Oona Out of Order, The Splendid and the Vile: A Saga of Churchill Family and Defiance During the Blitz, The Glass Hotel, Midnight Sun (Twilight, #5), Tweet Cute, Don't Close Your Eyes, Piranesi, Complicated Moonlight (DCYE, #2), The Shadows Between Us, The Book of Longings, Caste: The Origins of Our Discontents, Home Before Dark, Sweep with Me (Innkeeper Chronicles, #4.5), A Fairy Awesome Story (A Fairy Awesome Story, #1), Network Effect (The Murderbot Diaries, #5), Before and After, Smoke Bitten (Mercy Thompson, #12), The Jane Austen Society, The City We Became (Great Cities, #1), Come Tumbling Down (Wayward Children, #5), Playing with Fire, One of Us Is Next (One of Us Is Lying, #2), Hamnet, The Kingdom of Back, Infinity Son (Infinity Cycle #1), The Only Good Indians, Hidden Valley Road: Inside the Mind of an American Family, A Heart So Fierce and Broken (Cursebreakers, #2), The Switch, The Evening and the Morning, Rodham, The Other Mrs., A Promised Land, The Night Watchman, Credence, The Empire of Gold (The Daevabad Trilogy, #3), Weather, A Good Neighborhood, Dear Ava,Fake It Til You Break It, Heart Bones, Transcendent Kingdom, Aurora Burning (The Aurora Cycle, #2), The Queen's Assassin (The Queen's Secret, #1), Bront?'s Mistress, Too Much and Never Enough: How My Family Created the World's Most Dangerous Man, Hate (Madison Kate, #1), Fake (Madison Kate, #3), Liar (Madison Kate, #2), Eight Perfect Murders, Troubled Blood (Cormoran Strike, #5), The Honey-Don't List, The Book of Lost Friends, Undercover Bromance (Bromance Book Club, #2), The Boatmans Daughter, The Mirror & the Light (Thomas Cromwell #3) The Henna Artist (The Henna Artist, #1), If It Bleeds, Cemetery Boys, The Mountains Sing, Be My Brayshaw (Brayshaw, #4), Boyfriend Material, Woven in Moonlight (Woven in Moonlight, #1), Yes No Maybe So, One to Watch, Migrations, You Deserve Each Other, Little Secrets, Deacon King Kong, You Are Not Alone, What You Wish For, The Hunter (Boston Belles, #1), The Travelers Within: Into The Unknown, Sigh Gone: A Misfits Memoir of Great Books Punk Rock and the Fight to Fit In, Gilded Dreams (Newport's Gilded Age #2)"

doc6 <-  '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100'

doc7 <- 'Sarah J. Maas, Jeanine Cummins,T.J. Klune, ???????? ??????????, Brit Bennett, Emily Henry, V.E. Schwab, Kate Elizabeth Russell, Matt Haig, Cassandra Clare, Ann Napolitano, Siobhan Davis, Silvia Moreno-Garcia  , Siobhan Davis, Suzanne Collins, Siobhan Davis, Simone St. James, Lucy Foley, Glennon Doyle, Kenneth   Thomas, Liz Moore, Kenneth Thomas, Abi Dar?, Grady Hendrix, Rebecca Serle, Margarita Montimore, Erik Larson, Emily St. John Mandel, Stephenie Meyer, Emma Lord, Lynessa James, Susanna Clarke, Lynessa Layne, Tricia Levenseller, Sue Monk Kidd, Isabel Wilkerson, Riley Sager, Ilona Andrews, Ellie Aiden, Martha Wells, Andrew Shanahan, Patricia Briggs, Natalie Jenner, N.K. Jemisin, Seanan McGuire, L.J. Shen, Karen M. McManus, Maggie OFarrell, Marie Lu, Adam Silvera, Stephen Graham Jones, Robert Kolker, Brigid Kemmerer, Beth OLeary, Ken Follett, Curtis Sittenfeld      Mary Kubica, Barack Obama, Louise Erdrich, Penelope Douglas, S.A. Chakraborty, Jenny Offill, Therese Anne Fowler, Ilsa Madden-Mills, Meagan Brandy, Colleen Hoover, Yaa Gyasi, Amie Kaufman, Melissa de la Cruz, Finola Austin, Mary L. Trump, Tate James, Tate James, Tate James, Peter Swanson, Robert Galbraith, Christina Lauren, Lisa Wingate, Lyssa Kay Adams, Andy  Davidso, Hilary Mantel, Alka Joshi, Stephen King, Aiden Thomas, Nguy???n Phan Qu??? Mai, Meagan Brandy, Alexis  Hall, Isabel Iba?ez, Becky Albertalli, Kate Stayman-London, Charlotte McConaghy, Sarah Hogle, Jennifer Hillier, James   McBride, Greer Hendricks, Katherine Center, L.J. Shen, Daniel Mode,Phuc  Tran, Donna Russo Morin'

## ------------------------------------------------------------------------
doc8 <- 'Da Vinci Code,The , Harry Potter and the Deathly Hallows, Harry Potter and the Philosophers Stone, Harry Potter and the Order of the Phoenix, Fifty Shades of Grey,Harry Potter and the Goblet of Fire,Harry Potter and the Chamber of Secrets,Harry Potter and the Prisoner of Azkaban,Angels and Demons,Harry Potter and the Half-blood Prince:Childrens Edition,Fifty Shades Darker,Twilight,Girl with the Dragon Tattoo,The:Millennium Trilogy,Fifty Shades Freed, Lost Symbol,The, New Moon, Deception Point, Eclipse, Lovely Bones,Curious Incident of the Dog in the Night-time, Digital Fortress ,Short History of Nearly Everything, Girl Who Played with Fire,The:Millennium Trilogy, Breaking Dawn,Very Hungry Caterpillar,The:The Very Hungry Caterpillar,Gruffalo,Jamies 30-Minute Meals,Kite Runner,One Day,Thousand Splendid Suns,Girl Who Kicked the Hornets Nest The:Millennium Trilogy,Time Travelers Wife,Atonement,Bridget Joness Diary:A Novel,World According to Clarkson,Captain Corellis Mandolin,Sound of Laughter,Life of Pi,Billy Connolly,Child Called It,Gruffalos Child,Angelas Ashes:A Memoir of a Childhood,Birdsong,Northern Lights:His Dark Materials S,Labyrinth,Harry Potter and the Half-blood Prince,The Help,Man and Boy,Memoirs of a Geisha,No.1 Ladies Detective AgencyThe:No.1 Ladies Detective Agency S,Island,PS, I Love You,You are What You Eat:The Plan That Will Change Your Life,Shadow of the Wind,Tales of Beedle the Bard,Broker,Dr. Atkins New Diet Revolution:The No-hunger Luxurious Weight Loss P, Subtle Knife The:His Dark Materials S,Eats Shoots and Leaves:The Zero Tolerance Approach to Punctuation,Delias How to Cook:(Bk.1),Chocolat,Boy in the Striped Pyjamas,My Sisters Keeper,Amber Spyglass,The:His Dark Materials S,To Kill a Mockingbird,Men are from Mars Women are from Venus:A Practical Guide for Improvin, Dear Fatty,Short History of Tractors in Ukrainian,Hannibal,Lord of the Rings,Stupid White Men:and Other Sorry Excuses for the State of the Natio, Interpretation of Murder,Sharon Osbourne Extreme:My Autobiography,Alchemist The:A Fable About Following Your Dream,At My Mothers Knee ...:and Other Low Joints,Notes from a Small Island,Return of the Naked Chef,Bridget Jones: The Edge of Reason,Jamies Italy,I Can Make You Think,Down Under,Summons,Small Island,Nigella Express,,Brick Lane,Memory Keepers Daughter,Room on the Broom,About a Boy,My Booky Wook,God Delusion,Beano Annual,White Teeth,House at Riverton,Book Thief,Nights of Rain and Stars,Ghost,Happy Days with the Naked Chef,Hunger Games The:Hunger Games Trilogy,Lost Boy The:A Foster Childs Search for the Love of a Family,Jamies Ministry of Food:Anyone Can Learn to Cook in 24 Hours' 

doc9 <-  'Brown Dan,Rowling J.K.,Rowling, J.K., Rowling, J.K.,James, E. L.,Rowling, J.K., Rowling, J.K., Rowling, J.K., Brown Dan,  Rowling, J.K., James, E. L.,Meyer Stephenie, Larsson Stieg, James E. L., Brown Dan, Meyer Stephenie, Brown Dan, Meye Stephenie,Sebold Alice, Haddon Mark ,Brown Dan, Bryson Bill, Larsson Stieg , Meyer Stephenie, Carle Eric, Donaldson Julia, Oliver Jamie, Hosseini Khaled,Nicholls David, Hosseini Khaled, Larsson, Stieg , Niffenegger Audrey, McEwan Ian,  Fielding Helen, Clarkson Jeremy, Bernieres Louis de, Kay Peter, Martel Yann, Stephenson Pamela, Pelzer Dave, Donaldson Julia, McCourt Frank, Faulks Sebastian, Pullman Philip, Mosse Kate, Rowling J.K., Stockett Kathryn, Parsons Tony, Golden Arthur, McCall Smith Alexander, Hislop Victoria, Ahern Cecelia, McKeith Gillian, Zafon Carlos Ruiz, Rowling J.K.,Grisham John,Atkins Robert C., Pullman Philip, Truss Lynne, SmithDelia,Harris Joanne, Boyne John, Picoult Jodi, Pullman Philip, Lee Harper,Gray John,French Dawn, Lewycka Marina, Harris Thomas, Tolkien J. R. R.,Moore Michael,Rubenfeld Jed, Osbourne Sharon,Coelho Paulo, OGrady Paul,Bryson Bill, Oliver Jamie, Fielding Helen,Oliver Jamie, McKenna Paul,Bryson Bill,Grisham John,Levy Andrea,Lawson Nigella, Ali Monica,Edwards Kim,Donaldson Julia, Hornby Nick,Brand Russell,Dawkins Richard,0,Smith Zadie,Morton Kate,Zusak, Markus,Binchy Maeve,Harris Robert, Oliver Jamie, Collins Suzanne,Pelzer Dave, Oliver Jamie'

doc10 <- ' Transworld,Bloomsbury, Bloomsbury, Bloomsbury, Random House, Bloomsbury, Bloomsbury, Bloomsbury, Transworld, Bloomsbury, Random House,Little, Brown Book, Quercus, Random House ,Transworld, Little, Brown Book, Transworld, Little Brown Book, Pan Macmillan, Random House, Transworld, Transworld, Quercus, Little, Brown Book, Penguin, Pan Macmillan, Penguin, Bloomsbury, Hodder & Stoughton, Bloomsbury, Quercus, Random House, Random House, Pan Macmillan, Penguin, Random House, Random House,Canongate, HarperCollins, Orion, Pan Macmillan, HarperCollins, Random House,Scholastic Ltd., Orion, Bloomsbury, Penguin, HarperCollins, Random House, Little Brown Book, Headline, HarperCollins, Penguin, Orion, Bloomsbury, Random House, Random House, Scholastic Ltd., Profile Books Group, Random House, Transworld, Random House Childrens Books G, Hodder & Stoughton, Scholastic Ltd., Random House, HarperCollins, Random House Penguin,Random House,HarperCollins,Penguin, Headline, Little, Brown Book,HarperCollins, Transworld, Transworld, Penguin, Pan Macmillan, Penguin, Transworld, Transworld, Random House,Headline, Random House, Transworld, Penguin, Pan Macmillan, Penguin,Hodder & Stoughton, Transworld, D.C. Thomson, Penguin, Pan Macmillan, Transworld,Orion, Random House, Penguin, Scholastic Ltd., Orion, Penguin'

doc11 <- 'Crime, Childrens Fiction, Childrens Fiction, Childrens Fiction, Romance, Childrens Fiction, Childrens Fiction, Childrens Fiction, Crime, Childrens Fiction, Romance, Young Adult Fiction, Crime, Romance, Crime, Young Adult Fiction, Crime, Young Adult Fiction, General, General, Crime, Popular Science, Crime, YoungAdultFiction, PictureBooks, PictureBooks, Food, General, General, General, Crime, General, General, General, Humour:Collections, General, Autobiography:General, General, Biography:TheArts,Autobiography:General, PictureBooks, Autobiography:General, General, Young Adult Fiction, General, Science Fiction, General, General, General, Crime, General, General, Fitness, General, Childrens Fiction, Crime, Fitness, Young Adult Fiction, Usage, Food, General, YoungAdultFiction, General, YoungAdultFiction, General, Popular Culture, Autobiography:TheArts, General, Crime, Science Fiction, Current Affairs, Crime, Autobiography:TheArts, General, Autobiography:TheArts, Travel Writing, Food, General, National, Fitness, Travel Writing, Crime, General, Food, General, General, PictureBooks, General, Autobiography:TheArts, Popular Science, Childrens Annuals, General, General, General, General, General, Food, Young Adult Fiction, Biography:General, Food'



## ------------------------------------------------------------------------
doc.list <- list(doc1, doc2, doc3, doc4, doc5, doc6, doc7, doc8, doc9, doc10, doc11)
N.docs <- length(doc.list)
names(doc.list) <- paste0("doc", c(1:N.docs))##Paste0 combines two agruments. In this case the doc names will be applied to list


## ------------------------------------------------------------------------
doc.list


## ------------------------------------------------------------------------
##Contain a common theme
query <- 'fiction'


## ------------------------------------------------------------------------
#install.packages("tm", dependencies = TRUE)
#install.packages("SnowballC", dependencies = TRUE)
#tm is a text mining package and Snowball is a package to allow us to stem words


## ------------------------------------------------------------------------
 library(tm)
library(SnowballC)


## ------------------------------------------------------------------------
##Creating corpus
##Corpus is a collection of text documents with extensive manual annotations
my.docs <- VectorSource(c(doc.list, query))
## Harry potter query is down as content 7
my.docs$Names <- c(names(doc.list), "query")

my.corpus <- Corpus(my.docs)
#Checking contents of the corpus
my.corpus


## ------------------------------------------------------------------------
##Standardise
#This shows us the number of tranformations we can perform on our data
#During the web scraping process we have already prepocessed some of the data
getTransformations()
#Lists what transformations we can use


## ------------------------------------------------------------------------
#removePumctuation
my.corpus <- tm_map(my.corpus, removePunctuation)
my.corpus$doc1


## ------------------------------------------------------------------------
#stemDocument, stem the word down to its origin, numbers would be number
my.corpus <- tm_map(my.corpus, stemDocument)
my.corpus$doc1

my.corpus <- tm_map(my.corpus, removeNumbers)
my.corpus$doc1

## ------------------------------------------------------------------------
#Make all words lower case
my.corpus <- tm_map(my.corpus, tolower)
#Remove whitespace
my.corpus <- tm_map(my.corpus, stripWhitespace)
my.corpus
#Viewing amendments we made to the document
inspect(my.corpus)

## ------------------------------------------------------------------------
#Term document matrix is a collection of column vectors existing in a space defined by rows, the query also lives in the space
term.doc.matrix.stm <- TermDocumentMatrix(my.corpus)
inspect(term.doc.matrix.stm[0:14, ])


## ------------------------------------------------------------------------
#Making the matrix dense
term.doc.matrix <- as.matrix(term.doc.matrix.stm)

cat("Dense matrix representation costs", object.size(term.doc.matrix), "bytes.\n", 
    "Simple triplet matrix representation costs", object.size(term.doc.matrix.stm), 
    "bytes.")
#Dense matrix is much greater than the simple triple matrix

## ------------------------------------------------------------------------
#Choice and implementation
get.tf.idf.weights <- function(tf.vec, df) { #Reuquire 2 inputs, term frequency vector and our document frequency list
  # Computes tfidf weights from a term frequency vector and a document
  # frequency scalar
  weight = rep(0, length(tf.vec))#Define weight varibale that repeats 0 till the length of the frequency vector
  weight[tf.vec > 0] = (1 + log2(tf.vec[tf.vec > 0])) * log2(N.docs/df)
  weight
}

cat("A word appearing in 4 of 6 documents, occuring 1, 2, 3, and 6 times, respectively: \n", 
    get.tf.idf.weights(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0), 11))
#SHOWS US THE DECIMAL VALUE OF THE TERM FREQUENCY

## ------------------------------------------------------------------------
get.weights.per.term.vec <- function(tfidf.row) {
  term.df <- sum(tfidf.row[1:N.docs] > 0)#Shows the sum of the documents in the row if greater than 0
  tf.idf.vec <- get.tf.idf.weights(tfidf.row, term.df)#term.df is the sum of all columns in the matrix 
  return(tf.idf.vec)
}

tfidf.matrix <- t(apply(term.doc.matrix, c(1), FUN = get.weights.per.term.vec))
colnames(tfidf.matrix) <- colnames(term.doc.matrix)

tfidf.matrix[0:3, ]


## ------------------------------------------------------------------------
angle <- seq(-pi, pi, by = pi/16)
plot(cos(angle) ~ angle, type = "b", xlab = "angle in radians", main = "Cosine similarity by angle")


## ------------------------------------------------------------------------
tfidf.matrix <- scale(tfidf.matrix, center = FALSE, scale = sqrt(colSums(tfidf.matrix^2)))
tfidf.matrix[0:3, ]
#Data has been modified based on the angles


## ------------------------------------------------------------------------
#Matrix multiplication and separating the query
query.vector <- tfidf.matrix[, (N.docs + 1)]
tfidf.matrix <- tfidf.matrix[, 1:N.docs]


## ------------------------------------------------------------------------
doc.scores <- t(query.vector) %*% tfidf.matrix


## ------------------------------------------------------------------------
#Storing the results
#List docs from 1-6 and take the scores from doc.score and show the text in the documents.
results.df <- data.frame(doc = names(doc.list), score = t(doc.scores), text = unlist(doc.list))
results.df <- results.df[order(results.df$score, decreasing = TRUE), ]


## ------------------------------------------------------------------------
options(width = 2000)
print(results.df, row.names = FALSE, right = FALSE, digits = 2)
#SHOWS us the most relevant query from the beginning

