// App.js

/*
    By Larsen Freund. Template Copied over from Github CS_340 guide.
*/


var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static('public'))
PORT        = 20076;                 // Set a port number at the top so it's easy to change in the future

var db = require('./database/db-connector')

const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

/*
    ROUTES
*/
// app.js 

app.get('/', function(req, res)
    {
        res.render('index');      
                      // Note the call to render() and not send(). Using render() ensures the templating engine
    });
    
    app.get('/index', function(req, res)
    {
        res.render('index');      
                      // Note the call to render() and not send(). Using render() ensures the templating engine
    }); 
    app.get('/Zoo', function(req, res)
    {  
        let query1 = "SELECT * FROM Zoo;";               // Define our query

        db.pool.query(query1, function(error, rows, fields){ 
            
            console.log(rows);// Execute the query
            res.render('Zoo', {data: rows});                  // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    }); 
    
app.delete('/delete-zoo-ajax', function(req,res,next){
  let data = req.body;
  console.log(data.id);
  let zooID = parseInt(data.id);
  console.log(zooID)
  let deleteZoo= `DELETE FROM Zoo WHERE zoo_ID = ${zooID}`;  

    
        // Run the 1st query
        db.pool.query(deleteZoo, [zooID], function(error, rows, fields){
            if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
            }

            else
            {
               // becasue this app is terrible we will just perform  a select

               q2 = 'SELECT * FROM Zoo;';
               db.pool.query(q2, function(error, rows, fields){

                if (error) {
                    
                    console.log(error);
                    res.sendStatus(400);
                }
                else
                {
                    res.status(200).send(rows);

                }
                })    
                    
                
            }
})});

/*

mysql -u pcs_340freundl] -p -h classmysql.engr.oregonstate.edu
    CREATE OR REPLACE TABLE Zoo(
    zoo_ID int(11) NOT NULL AUTO_INCREMENT,
    zoo_Name varchar(64) not NULL,lVwxNwJF0jiv
    phone varchar(16),
    email varchar(128),
    num_Habs int(11),
    num_Animals int(11),
    PRIMARY KEY(zoo_ID,zoo_Name), -- HMMM
    CONSTRAINT uniName UNIQUE(zoo_Name)
  );
*/


// app.js - ROUTES section

app.post('/add-zoo-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

   

    // Create the query and run it on the database
    query1 = `INSERT INTO Zoo (zoo_Name, phone, email, num_Habs, num_Animals) VALUES ('${data.zoo_Name}', '${data.phone}', '${data.email}', '${data.num_Habs}','${data.num_Animals}')`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on Zoo
            query2 = `SELECT * FROM Zoo;`;
            db.pool.query(query2, function(error, rows, fields){

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.')
});