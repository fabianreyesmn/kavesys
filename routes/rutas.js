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

  if(!nombre || !email || !mensaje)
    return res.status(400).json({ error: 'Faltan campos requeridos' });

  try {
    //Configura el transporte SMTP
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'plasticoskavesystem@gmail.com',
        pass: process.env.EMAIL_PASSWORD,
      },
    });

    const mailOptions = {
      from: `"Contacto Web - Plásticos KAVE" <plasticoskave@hotmail.com>`,
      to: 'plasticoskavesystem@gmail.com',
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
  } 
  catch(error) {
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

  const { getAuth } = require('firebase-admin/auth');

  router.delete('/deleteUser/:id', verifyToken, async (req, res) => {
    try {
      const userId = req.params.id;

      const [result] = await db.query('DELETE FROM Usuario WHERE ID_Usuario = ?', [userId]);
      if (result.affectedRows === 0) {
        return res.status(404).json({ error: 'Usuario no encontrado en la base de datos.' });
      }

      await getAuth().deleteUser(userId);

      res.status(200).json({ message: 'Usuario eliminado correctamente.' });
    } catch (error) {
      console.error('Error al eliminar usuario:', error);
      res.status(500).json({ error: 'Error al eliminar usuario.' });
    }
  });

router.get('/catalogo', verifyToken, async (req, res) => {
  try {
    const sql = `
      SELECT 
        i.ID_Inventario,
        f.Clave,
        i.Descripcion,
        i.ID_Categoria,
        f.Piezas,
        f.Precio,
        f.Existencias,
        COALESCE(c.ExistenciasMinimas, 0) AS ExistenciasMinimas,
        COALESCE(c.ExistenciasMaximas, 0) AS ExistenciasMaximas
      FROM ProductoInventario i
      LEFT JOIN ProductoFabricado f ON f.ID_Inventario = i.ID_Inventario
      LEFT JOIN ConfiguracionProducto c ON c.ID_Inventario = i.ID_Inventario
      ORDER BY CAST(SUBSTR(i.ID_Inventario, 3) AS UNSIGNED);
    `;

    const [rows] = await db.query(sql);
    res.json(rows);
  } catch (error) {
    console.error('Error en la consulta:', error.sqlMessage || error.message);
    res.status(500).json({ error: 'Error al obtener el catálogo' });
  }
});

//altas
router.post('/alta-producto', verifyToken, async (req, res) => {
  try {
    const {
      Clave,
      Descripcion,
      ID_Categoria,
      Piezas,
      Precio,
      Existencias,
      ExistenciasMinimas,
      ExistenciasMaximas
    } = req.body;

    if (!Clave || !Descripcion || !ID_Categoria) {
      return res.status(400).json({ error: 'Clave, Descripción y Categoría son obligatorias' });
    }

    const [rows] = await db.query(`
      SELECT ID_Inventario
      FROM ProductoInventario
      ORDER BY CAST(SUBSTR(ID_Inventario, 3) AS UNSIGNED) DESC
      LIMIT 1;
    `);

    let nuevoID = 'PI001';
    if (rows.length > 0) {
      const ultimoNumero = parseInt(rows[0].ID_Inventario.substring(2)) + 1;
      nuevoID = 'PI' + ultimoNumero;
    }

    await db.query(
      `INSERT INTO ProductoInventario (ID_Inventario, Descripcion, ID_Categoria)
       VALUES (?, ?, ?)`,
      [nuevoID, Descripcion, ID_Categoria]
    );

    const configID = 'CP' + nuevoID.substring(2);
    await db.query(
      `INSERT INTO ConfiguracionProducto
       (ID_ConfiguracionProducto, ID_Inventario, ExistenciasMinimas, ExistenciasMaximas)
       VALUES (?, ?, ?, ?)`,
      [configID, nuevoID, ExistenciasMinimas, ExistenciasMaximas]
    );

    await db.query(
      `INSERT INTO ProductoFabricado (ID_Inventario, Clave, Piezas, Precio, Existencias)
       VALUES (?, ?, ?, ?, ?)`,
      [nuevoID, Clave, Piezas, Precio, Existencias]
    );

    res.status(201).json({
      message: 'Producto agregado correctamente',
      ID_Inventario: nuevoID
    });

  } catch (error) {
    console.error('Error en /alta-producto:', error.sqlMessage || error.message);
    res.status(500).json({ error: 'Error al registrar el producto' });
  }
});

router.put('/actualizar-producto/:id', verifyToken, async (req, res) => {
  try {
    const id = req.params.id;
    const {
      Descripcion,
      ID_Categoria,
      Precio,
      Piezas,
      Existencias,
      ExistenciasMinimas,
      ExistenciasMaximas
    } = req.body;

    await db.query(`
      UPDATE ProductoInventario
      SET Descripcion = ?, ID_Categoria = ?
      WHERE ID_Inventario = ?;
    `, [Descripcion, ID_Categoria, id]);

    await db.query(`
      UPDATE ProductoFabricado
      SET Precio = ?, Piezas = ?, Existencias = ?
      WHERE ID_Inventario = ?;
    `, [Precio, Piezas, Existencias, id]);

    await db.query(`
      INSERT INTO ConfiguracionProducto (ID_ConfiguracionProducto, ID_Inventario, ExistenciasMinimas, ExistenciasMaximas)
      VALUES (?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
        ExistenciasMinimas = VALUES(ExistenciasMinimas),
        ExistenciasMaximas = VALUES(ExistenciasMaximas);
    `, [
      'CP' + id.substring(2),
      id,
      ExistenciasMinimas,
      ExistenciasMaximas
    ]);

    res.json({ message: 'Producto actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar producto:', error);
    res.status(500).json({ error: 'Error al actualizar el producto' });
  }
});


router.delete('/eliminar-producto/:id', verifyToken, async (req, res) => {
  try {
    const idInventario = req.params.id;

    await db.query(`DELETE FROM ConfiguracionProducto WHERE ID_Inventario = ?`, [idInventario]);
    await db.query(`DELETE FROM ProductoFabricado WHERE ID_Inventario = ?`, [idInventario]);
    await db.query(`DELETE FROM ProductoInventario WHERE ID_Inventario = ?`, [idInventario]);

    res.json({ message: 'Producto eliminado correctamente' });
  } catch (error) {
    console.error('Error en /eliminar-producto:', error.sqlMessage || error.message);
    res.status(500).json({ error: 'Error al eliminar el producto' });
  }
});

/* ===== APARTADO DE GESTION ===== */
router.get('/gestion/productos', verifyToken, async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        i.ID_Inventario AS id,
        f.Clave AS code,
        i.Descripcion AS description,
        f.Existencias AS stock,
        IF(f.Existencias > 0, 1, 0) AS active
      FROM ProductoInventario i
      LEFT JOIN ProductoFabricado f ON i.ID_Inventario = f.ID_Inventario
      ORDER BY i.ID_Inventario ASC;
    `);
    res.json(rows);
  } catch (error) {
    console.error('Error obteniendo productos:', error);
    res.status(500).json({ error: 'Error al obtener productos.' });
  }
});

/* ===== Registrar movimiento ===== */
router.post('/gestion/movimiento', verifyToken, async (req, res) => {
  try {
    const userId = req.user.uid; // ✅ tomado directamente del token verificado
    const { ID_Inventario, Fecha, TipoMovimiento, Cantidad } = req.body;

    if (!ID_Inventario || !Fecha || !TipoMovimiento || !Cantidad) {
      return res.status(400).json({ error: 'Datos incompletos.' });
    }

    // Generar ID automático del movimiento
    const [rows] = await db.query('SELECT COUNT(*) AS total FROM Movimiento');
    const nuevoId = 'MOV' + (rows[0].total + 1).toString().padStart(3, '0');

    // Insertar el registro en la tabla Movimiento
    await db.query(`
      INSERT INTO Movimiento 
      (ID_Movimiento, ID_Usuario, ID_Inventario, Fecha, TipoMovimiento, Cantidad)
      VALUES (?, ?, ?, ?, ?, ?)`,
      [nuevoId, userId, ID_Inventario, Fecha, TipoMovimiento, Cantidad]
    );

    // Actualizar existencias en ProductoFabricado
    const factor = TipoMovimiento.toLowerCase() === 'entrada' ? 1 : -1;
    await db.query(`
      UPDATE ProductoFabricado
      SET Existencias = GREATEST(Existencias + (? * ?), 0)
      WHERE ID_Inventario = ?`,
      [factor, Cantidad, ID_Inventario]
    );

    res.status(201).json({
      message: 'Movimiento registrado correctamente',
      id: nuevoId
    });

  } catch (error) {
    console.error('Error registrando movimiento:', error.sqlMessage || error.message);
    res.status(500).json({ error: 'Error al registrar el movimiento.' });
  }
});


/* ===== Últimos movimientos ===== */
router.get('/gestion/movimientos', verifyToken, async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        m.ID_Movimiento,
        m.ID_Inventario,
        i.Descripcion AS Producto,
        m.Fecha,
        m.TipoMovimiento AS Tipo,
        m.Cantidad,
        f.Existencias AS StockActual,
        u.Nombre AS NombreUsuario
      FROM Movimiento m
      LEFT JOIN ProductoInventario i ON m.ID_Inventario = i.ID_Inventario
      LEFT JOIN ProductoFabricado f ON i.ID_Inventario = f.ID_Inventario
      LEFT JOIN Usuario u ON m.ID_Usuario = u.ID_Usuario
      ORDER BY m.Fecha DESC, m.ID_Movimiento DESC
      LIMIT 50;
    `);

    res.json(rows);
  } catch (error) {
    console.error('Error obteniendo movimientos:', error);
    res.status(500).json({ error: 'Error al obtener movimientos.' });
  }
});

module.exports = router;