module SampleBooks
  Mockingbird = { title: "To Kill A Mockingbird",
                  author: { "first_name" => "Harper",
                            "last_name" => "Lee"},
                  genre: "Fiction" }

  Wonderland = { title: "Hard-Boiled Wonderland and the End of the World",
                 author: { "first_name" => "Haruki",
                           "last_name" => "Murakami"},
                 genre: "Fiction" }

  One_Q84 = { title: "1Q84",
              author: { "first_name" => "Haruki",
                        "last_name" => "Murakami"},
              genre: "Fiction" }

  Steel = { title: "Guns, Germs and Steel",
            author: { "first_name" => "Jared",
                      "last_name" => "Diamond"},
            genre: "History" }

  Underground = { title: "Underground: The Tokyo Gas Attack and the Japanese Pysche",
                  author: { "first_name" => "Haruki",
                            "last_name" => "Murakami" },
                  genre: "Non-Fiction" }


  Poodir = { title: "Practical Object-Oriented Design In Ruby",
             author: { "first_name" => "Sandi",
                       "last_name" => "Metz" },
             genre: "Programming" }

  Time = { title: "A Brief History Of Time",
           author: { "first_name" => "Stephen",
                     "last_name" => "Hawking" },
           genre: "Popular Science" }

  WhatWhat = { title: "What Is The What",
               author: { "first_name" => "Dave",
                         "last_name" => "Eggars" },
               genre: "Memoir" }

  Running = { title: "What I Talk About When I Talk About Running",
              author: { "first_name" => "Haruki",
                        "last_name" => "Murakami" },
              genre: "Memoir" }

  Autumns = { title: "The Thousand Autumns of Jacob de Zoet: A novel",
              author: { "first_name" => "David",
                        "last_name" => "Mitchell" },
              genre: "Fiction" }

  Lib = [Mockingbird, Wonderland, One_Q84, Steel,
         Underground, Poodir, Time, WhatWhat, Running, Autumns]
end
