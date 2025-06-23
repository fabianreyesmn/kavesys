const express = require("express"); //Importar la librería express
const router = express.Router();
const db = require('../db');


router.get('/', (req, res) => {
    res.send({ message:"Hola mundo, soy Gustavo" });
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


router.get('/usuarios', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM usuario');
        res.json(rows);
    } 
    catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Error al obtener usuarios' });
    }
});

router.get('/productosfabricados', async (req, res) => {
  try {
    const sql = `SELECT Clave, Descripcion, Piezas, Precio 
                 FROM ProductoFabricado fabricado, ProductoInventario inventario
                 WHERE fabricado.ID_Inventario = inventario.ID_Inventario;`;

    const [rows] = await db.query(sql);
    res.json(rows);
  } catch (error) {
    console.error('Error en consulta:', error);
    res.status(500).json({ error: 'Error en la consulta' });
  }
});


module.exports = router;