const express = require("express"); //Importar la librería express
const router = express.Router();
const db = require('../db');
const { verifyToken } = require('../middleware/auth'); //Importar middleware de verificación
const nodemailer = require('nodemailer');

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

//NODEMAILER
router.post('/enviar-contacto', async (req, res) => {
  const { nombre, email, mensaje } = req.body;

  if (!nombre || !email || !mensaje)
    return res.status(400).json({ error: 'Faltan campos requeridos' });

  try {
    // Configura el transporte SMTP
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'plasticoskavesystem@gmail.com',
        pass: 'qgxruiyasqwuyufn',
      },
    });

const mailOptions = {
  from: `"Contacto Web - Plásticos KAVE" <plasticoskave@hotmail.com>`,
  to: 'plasticoskave@hotmail.com',
  subject: `📩 Nuevo mensaje de contacto - ${nombre}`,
  html: `
  <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f7f9fb; padding:40px; color:#333;">
    <div style="max-width:600px; margin:auto; background:#fff; border-radius:12px; box-shadow:0 5px 15px rgba(0,0,0,0.1); overflow:hidden;">
      
      <div style="background:#0d6efd; color:#fff; padding:20px; text-align:center;">
        <h2 style="margin:0;">Plásticos KAVE</h2>
        <p style="margin:0;">Nuevo mensaje desde el sitio web</p>
      </div>

      <div style="padding:30px;">
        <h3 style="color:#0d6efd; margin-bottom:15px;">Detalles del remitente</h3>

        <table style="width:100%; border-collapse:collapse; margin-bottom:20px;">
          <tr>
            <td style="padding:8px; font-weight:600; width:30%;">👤 Nombre:</td>
            <td style="padding:8px; background:#f3f6f9;">${nombre}</td>
          </tr>
          <tr>
            <td style="padding:8px; font-weight:600;">📧 Correo:</td>
            <td style="padding:8px; background:#f3f6f9;">${email}</td>
          </tr>
        </table>

        <h3 style="color:#0d6efd; margin-bottom:10px;">💬 Mensaje</h3>
        <div style="background:#f9fafc; padding:15px; border-left:4px solid #0d6efd; border-radius:6px; white-space:pre-line;">
          ${mensaje}
        </div>

        <p style="margin-top:30px; font-size:0.9rem; color:#777; text-align:center;">
          Este mensaje fue enviado desde el formulario de contacto del sitio web de 
          <strong>Plásticos KAVE S.A. de C.V.</strong><br>
          <a href="http://www.plasticoskave.com.mx" style="color:#0d6efd; text-decoration:none;">
            www.plasticoskave.com.mx
          </a>
        </p>
      </div>

      <div style="background:#0d6efd; color:#fff; text-align:center; padding:10px; font-size:0.85rem;">
        © ${new Date().getFullYear()} Plásticos KAVE S.A. de C.V. | Aguascalientes, México
      </div>
    </div>
  </div>
  `
};

    await transporter.sendMail(mailOptions);

    console.log(`Correo de contacto enviado por ${email}`);
    res.json({ ok: true, msg: 'Correo enviado correctamente' });
  } catch (error) {
    console.error('Error al enviar correo:', error);
    res.status(500).json({ error: 'No se pudo enviar el correo' });
  }
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