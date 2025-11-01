const express = require("express"); //Importar la librería express
const bodyParser = require("body-parser");
const misrutas = require('./routes/rutas');
const cors = require('cors');

const app = express(); //Crear el servidor
const port = process.env.PORT || 3000;

const corsOptions = {
  origin: 'http://localhost:4200',
  optionsSuccessStatus: 200 
};
app.use(cors(corsOptions));

app.use(bodyParser.urlencoded({ extended:false }));
app.use(bodyParser.json());
app.use('/', misrutas);

app.listen(port, () => {
    console.log(`Servidor en ejecución http://localhost:${port}`);
})