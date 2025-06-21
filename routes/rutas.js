const express = require("express"); //Importar la librería express
const router = express.Router();


router.get('/', (req, res) => {
    res.send({ message:"Hola mundo soy Gustavo" });
});

router.get('/ayuda', (req, res) => {
    res.send({ message:"En qué te ayudo soy Gustavo" });
});

router.get('/ayuda/:name', (req, res) => {
    res.send({ message:`Hola ${req.params.name} en qué te ayudo` });
});

router.get('/prueba', (req, res) => {
    res.send({ message:`Hola ${req.query.name} ${req.query.apellido}` });
});


module.exports = router;