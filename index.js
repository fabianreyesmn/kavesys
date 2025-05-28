const express = require('express');
const helmet = require('helmet');
const app = express();

require('dotenv').config();

const port = process.env.PORT || 3000;

app.use(helmet());

app.get('/', (req, res) => {
  res.send('Servidor funcionando');
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});

