const express = require("express"); //Importar la librería express
const router = express.Router();
const db = require('../db');
const { verifyToken } = require('../middleware/auth'); //Importar middleware de verificación


router.get('/', (req, res) => {
    res.status(200).send({ status: "ok", message: "Hola mundo, servidor Linux en funcionamiento." }); //200=Ok
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


//Creación del usuario en la base de datos, 
router.post('/registrar_usuario', verifyToken, async (req, res) => {
    const id_usuario = req.user.uid;
    const { username } = req.body; 

    if(!id_usuario) {
        return res.status(400).send({ error: 'No se pudo identificar al usuario desde el token.' });
    }
    if(!username) {
        return res.status(400).send({ error: 'El nombre de usuario es requerido en el body.' });
    }

    try {
        const sql = 'INSERT INTO Usuario (ID_Usuario, Nombre, Tipo) VALUES (?, ?, "Empleado")';
        await db.query(sql, [id_usuario, username]); 
        res.status(201).send({ message: 'Usuario registrado en MySQL' });
    } 
    catch(error) {
        console.error('Error al insertar usuario en MySQL:', error);
        //Manejar error de clave duplicada en caso de que el usuario ya exista
        if(error.code === 'ER_DUP_ENTRY') {
             return res.status(409).send({ error: 'El usuario ya existe.' });
        }
        res.status(500).send({ error: 'Error al guardar usuario en la base de datos' });
    }
});

router.get('/usuarios', verifyToken, async (req, res) => {
    console.log(`Usuario ${req.user.uid} está solicitando la lista de usuarios.`);

    try {
        const [rows] = await db.query('SELECT * FROM usuario;');
        res.json(rows);
    } 
    catch(error) {
        console.error(error);
        res.status(500).send({ error: 'Error al obtener usuarios' });
    }
});

router.get('/catalogo', verifyToken, async (req, res) => {
    console.log(`Usuario ${req.user.uid} está consultando el catálogo.`);
    
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