const express = require('express');
const app = express();
var bodyParser = require('body-parser');
const port = 3000;

app.use(express.static('public'));
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());

const db2 = require('./database');

const connection_string = `Driver=IBM i Access ODBC Driver;System=169.48.22.130;UID=NODEDEV2;Password=n0d32020`;

app.set('view engine', 'pug')

app.get('/listpatients', async (req, res) => {
    const results = await db2.executeStatement(`select * from patient.info`);
    res.render('listpatients', {listpatients: results});
});

app.get('/listpatients/:pnumber', async (req, res) => {
    const pnumber = req.params.pnumber;
    const patresults = await db2.executeStatement(`select * from patient.info where pnumber = ?`, [pnumber]);
    const histresults = await db2.executeStatement(`select * from patient.history where hpnumber = ?`, [pnumber]);

    res.render('patient', {patient: patresults, history: histresults});
});

app.get('/temp', async (req, res) => {
    const results = await db2.executeStatement(`select * from patient.info`); 
    res.json(results) 
});

app.get('/listpatients', async (req, res) => {
    res.render('listpatients', {search: true});
});

app.post('/listpatients', async (req, res) => {
    var listpatients = undefined;
    var searchName = req.body.patname;

    if (searchName !== undefined) {
        searchName = searchName.toUpperCase();
        listpatients = await db2.executeStatement(`select * from patient.info where upper(PFirstname) concat upper(PLastname) like '%' concat ? concat '%'`, [searchName]);
    }
    
    res.render('listpatients', {search: true, listpatients});
})

db2.connect(connection_string);
app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));
