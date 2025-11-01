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
        const defaultRole = 'almacenista';
        const sql = 'INSERT INTO Usuario (ID_Usuario, Nombre, Tipo) VALUES (?, ?, ?)';
        await db.query(sql, [id_usuario, username, defaultRole]); 
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
        const [rows] = await db.query('SELECT ID_Usuario, Nombre, Tipo FROM Usuario;');
        res.json(rows);
    } 
    catch(error) {
        console.error(error);
        res.status(500).send({ error: 'Error al obtener usuarios' });
    }
});

router.get('/getRol', verifyToken, async (req, res) => {
    try {
        const userId = req.user.uid;
        const [rows] = await db.query('SELECT Tipo FROM Usuario WHERE ID_Usuario = ?', [userId]);

        if(rows.length === 0) {
            //No debería pasar si el middleware 'verifyToken' ya crea al usuario
            return res.status(404).send({ error: 'Usuario no encontrado en la base de datos local.' });
        }
        res.status(200).json({ role: rows[0].Tipo });
    } 
    catch (error) {
        console.error('Error al obtener el rol del usuario:', error);
        res.status(500).send({ error: 'Error interno al consultar el rol.' });
    }
});

router.put('/actualizar_rol', verifyToken, async (req, res) => {
    const { userId, newRole } = req.body;
    const adminUserId = req.user.uid; //ID del que realiza el cambio

    if(!userId || !newRole) {
        return res.status(400).send({ error: 'Se requieren userId y newRole.' });
    }

    const validRoles = ['administrador', 'almacenista', 'produccion'];
    if(!validRoles.includes(newRole)) {
        return res.status(400).send({ error: 'Rol no válido.' });
    }

    try {
        const sql = 'UPDATE Usuario SET Tipo = ? WHERE ID_Usuario = ?';
        const [result] = await db.query(sql, [newRole, userId]);

        if(result.affectedRows === 0) {
            return res.status(404).send({ error: 'Usuario no encontrado.' });
        }
        console.log(`El admin ${adminUserId} cambió el rol de ${userId} a ${newRole}`);
        
        res.status(200).send({ message: 'Rol actualizado exitosamente' });
    } 
    catch(error) {
        console.error('Error al actualizar el rol:', error);
        res.status(500).send({ error: 'Error al actualizar el rol.' });
    }
});

router.get('/catalogo', verifyToken, async (req, res) => {
    console.log(`Usuario ${req.user.uid} está consultando el catálogo.`);
    
    try {
        const sql = `SELECT inventario.ID_Inventario, Clave, Descripcion, Piezas, Precio, Existencias, inventario.ID_Categoria 
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