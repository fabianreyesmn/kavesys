const express = require("express"); //Importar la librería express
const router = express.Router();
const db = require('../db');


router.get('/', (req, res) => {
    res.send({ message: "Hola mundo, servidor Linux en funcionamiento." });
});

router.get('/ayuda', (req, res) => {
    res.send({ message: "Bienvenido, ¿en qué te puedo ayudar?" });
});

router.get('/ayuda/:name', (req, res) => {
    res.send({ message: `Hola ${req.params.name}, ¿en qué te puedo ayudar?` });
});

router.get('/prueba', (req, res) => {
    res.send({ message: `Hola ${req.query.name} ${req.query.apellido}` });
});


router.get('/usuarios', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM usuario;');
        res.json(rows);
    } 
    catch(error) {
        console.error(error);
        res.status(500).send({ error: 'Error al obtener usuarios' });
    }
});

router.get('/catalogo', async (req, res) => {
  try {
    const sql = `SELECT inventario.ID_Inventario, Clave, Descripcion, Piezas, Precio, Existencias 
                FROM ProductoInventario inventario, ProductoFabricado fabricado
                WHERE fabricado.ID_Inventario = inventario.ID_Inventario 
                ORDER BY ROUND( SUBSTR(inventario.Id_Inventario, 3) ) ASC;`;

    const [rows] = await db.query(sql);
    res.json(rows);
  } 
  catch(error) {
    console.error('Error en la consulta: ', error);
    res.status(500).json({ error: 'Error en la consulta' });
  }
});


module.exports = router;