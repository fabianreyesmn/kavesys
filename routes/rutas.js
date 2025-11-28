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

router.get('/proveedores', verifyToken, async (req, res) => {
    try {
        const sql = `
            SELECT 
                p.RFC,
                p.RazonSocial,
                p.Telefono,
                p.CorreoElectronico,
                d.Calle,
                d.Numero,
                d.Fraccionamiento,
                d.CodigoPostal,
                d.Municipio,
                d.Estado
            FROM Proveedor p
            JOIN Direccion d ON p.ID_Direccion = d.ID_Direccion
            ORDER BY p.RazonSocial;
        `;
        const [rows] = await db.query(sql);
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener proveedores:', error);
        res.status(500).send({ error: 'Error al obtener la lista de proveedores.' });
    }
});

router.post('/alta-proveedor', verifyToken, async (req, res) => {
    try {
        const {
            RFC,
            RazonSocial,
            Telefono,
            CorreoElectronico,
            Calle,
            Numero,
            Fraccionamiento,
            CodigoPostal,
            Municipio,
            Estado
        } = req.body;

        if (!RFC || !RazonSocial || !Telefono || !CorreoElectronico || !Calle || !Numero || !Fraccionamiento || !CodigoPostal || !Municipio || !Estado) {
            return res.status(400).json({ error: 'Todos los campos son obligatorios.' });
        }

        await db.beginTransaction();

        const [rfcExistente] = await db.query(
            'SELECT RFC FROM Proveedor WHERE RFC = ?',
            [RFC]
        );

        if (rfcExistente.length > 0) {
            await db.rollback();
            return res.status(409).json({ error: `El RFC "${RFC}" ya está registrado.` });
        }

        const [lastDireccion] = await db.query(
            "SELECT ID_Direccion FROM Direccion ORDER BY CAST(SUBSTR(ID_Direccion, 4) AS UNSIGNED) DESC LIMIT 1"
        );
        
        let nuevoIdDireccion = 'DIR001';
        if (lastDireccion.length > 0) {
            const ultimoNumero = parseInt(lastDireccion[0].ID_Direccion.substring(3)) + 1;
            nuevoIdDireccion = 'DIR' + ultimoNumero.toString().padStart(3, '0');
        }

        await db.query(
            "INSERT INTO Direccion (ID_Direccion, Calle, Numero, Fraccionamiento, CodigoPostal, Municipio, Estado) VALUES (?, ?, ?, ?, ?, ?, ?)",
            [nuevoIdDireccion, Calle, Numero, Fraccionamiento, CodigoPostal, Municipio, Estado]
        );

        await db.query(
            'INSERT INTO Proveedor (RFC, RazonSocial, Telefono, CorreoElectronico, ID_Direccion) VALUES (?, ?, ?, ?, ?)',
            [RFC, RazonSocial, Telefono, CorreoElectronico, nuevoIdDireccion]
        );

        await db.commit();

        res.status(201).json({
            message: 'Proveedor agregado correctamente',
            RFC: RFC
        });

    } catch (error) {
        await db.rollback();
        console.error('Error en /alta-proveedor:', error);
        res.status(500).json({
            error: 'Error al registrar el proveedor.',
            details: error.sqlMessage || error.message
        });
    }
});

router.put('/actualizar-proveedor/:rfc', verifyToken, async (req, res) => {
    try {
        const { rfc } = req.params;
        const {
            RazonSocial,
            Telefono,
            CorreoElectronico,
            Calle,
            Numero,
            Fraccionamiento,
            CodigoPostal,
            Municipio,
            Estado
        } = req.body;

        if (!RazonSocial || !Telefono || !CorreoElectronico || !Calle || !Numero || !Fraccionamiento || !CodigoPostal || !Municipio || !Estado) {
            return res.status(400).json({ error: 'Todos los campos son obligatorios.' });
        }

        await db.beginTransaction();

        const [proveedor] = await db.query('SELECT ID_Direccion FROM Proveedor WHERE RFC = ?', [rfc]);

        if (proveedor.length === 0) {
            await db.rollback();
            return res.status(404).json({ error: 'Proveedor no encontrado.' });
        }
        const { ID_Direccion } = proveedor[0];

        await db.query(
            'UPDATE Proveedor SET RazonSocial = ?, Telefono = ?, CorreoElectronico = ? WHERE RFC = ?',
            [RazonSocial, Telefono, CorreoElectronico, rfc]
        );

        await db.query(
            'UPDATE Direccion SET Calle = ?, Numero = ?, Fraccionamiento = ?, CodigoPostal = ?, Municipio = ?, Estado = ? WHERE ID_Direccion = ?',
            [Calle, Numero, Fraccionamiento, CodigoPostal, Municipio, Estado, ID_Direccion]
        );

        await db.commit();

        res.status(200).json({ message: 'Proveedor actualizado correctamente' });

    } catch (error) {
        await db.rollback();
        console.error('Error en /actualizar-proveedor:', error);
        res.status(500).json({
            error: 'Error al actualizar el proveedor.',
            details: error.sqlMessage || error.message
        });
    }
});

router.delete('/eliminar-proveedor/:rfc', verifyToken, async (req, res) => {
    try {
        const { rfc } = req.params;

        await db.beginTransaction();

        const [materiasPrimas] = await db.query(
            'SELECT * FROM Proveedor_MateriaPrima WHERE RFC_Proveedor = ?',
            [rfc]
        );

        if (materiasPrimas.length > 0) {
            await db.rollback();
            return res.status(409).json({ error: 'No se puede eliminar el proveedor porque tiene materias primas asociadas.' });
        }

        const [proveedor] = await db.query('SELECT ID_Direccion FROM Proveedor WHERE RFC = ?', [rfc]);

        if (proveedor.length === 0) {
            await db.rollback();
            return res.status(404).json({ error: 'Proveedor no encontrado.' });
        }
        const { ID_Direccion } = proveedor[0];

        await db.query('DELETE FROM Proveedor WHERE RFC = ?', [rfc]);
        
        if (ID_Direccion) {
            await db.query('DELETE FROM Direccion WHERE ID_Direccion = ?', [ID_Direccion]);
        }

        await db.commit();

        res.status(200).json({ message: 'Proveedor eliminado correctamente' });

    } catch (error) {
        await db.rollback();
        console.error('Error en /eliminar-proveedor:', error);
        res.status(500).json({
            error: 'Error al eliminar el proveedor.',
            details: error.sqlMessage || error.message
        });
    }
});

router.get('/materias-primas', verifyToken, async (req, res) => {
    try {
        const sql = `
            SELECT 
                mp.Clave,
                pi.ID_Inventario,
                pi.Descripcion,
                pmp.RFC_Proveedor,
                p.RazonSocial,
                pmp.Costo,
                pmp.Existencias,
                COALESCE(cp.ExistenciasMinimas, 0) AS ExistenciasMinimas,
                COALESCE(cp.ExistenciasMaximas, 0) AS ExistenciasMaximas
            FROM MateriaPrima mp
            JOIN ProductoInventario pi ON mp.ID_Inventario = pi.ID_Inventario
            LEFT JOIN Proveedor_MateriaPrima pmp ON mp.Clave = pmp.Clave
            LEFT JOIN Proveedor p ON pmp.RFC_Proveedor = p.RFC
            LEFT JOIN ConfiguracionProducto cp ON pi.ID_Inventario = cp.ID_Inventario
            ORDER BY mp.Clave;
        `;
        const [rows] = await db.query(sql);
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener materias primas:', error);
        res.status(500).send({ error: 'Error al obtener la lista de materias primas.' });
    }
});

router.post('/alta-materia-prima', verifyToken, async (req, res) => {
    try {
        const {
            Clave,
            Descripcion,
            RFC_Proveedor,
            Costo,
            ExistenciasMinimas,
            ExistenciasMaximas
        } = req.body;

        if (!Clave || !Descripcion || !RFC_Proveedor || !Costo) {
            return res.status(400).json({ error: 'Clave, Descripción, Proveedor y Costo son obligatorios.' });
        }

        await db.beginTransaction();

        const [idExistente] = await db.query(
            'SELECT Clave FROM MateriaPrima WHERE Clave = ?',
            [Clave]
        );

        if (idExistente.length > 0) {
            await db.rollback();
            return res.status(409).json({ error: `La materia prima con Clave "${Clave}" ya está registrada.` });
        }

        const [lastInventario] = await db.query(
            "SELECT ID_Inventario FROM ProductoInventario ORDER BY CAST(SUBSTR(ID_Inventario, 3) AS UNSIGNED) DESC LIMIT 1"
        );
        
        let nuevoIDInventario = 'PI001';
        if (lastInventario.length > 0) {
            const ultimoNumero = parseInt(lastInventario[0].ID_Inventario.substring(2)) + 1;
            nuevoIDInventario = 'PI' + ultimoNumero.toString().padStart(3, '0');
        }

        await db.query(
            "INSERT INTO ProductoInventario (ID_Inventario, Descripcion, ID_Categoria) VALUES (?, ?, ?)",
            [nuevoIDInventario, Descripcion, 'MP'] // Asumiendo 'MP' como categoría para Materia Prima
        );

        await db.query(
            "INSERT INTO MateriaPrima (Clave, ID_Inventario) VALUES (?, ?)",
            [Clave, nuevoIDInventario]
        );

        await db.query(
            "INSERT INTO Proveedor_MateriaPrima (ID_Inventario, Clave, RFC_Proveedor, Costo, Existencias) VALUES (?, ?, ?, ?, ?)",
            [nuevoIDInventario, Clave, RFC_Proveedor, Costo, 0] // Existencias iniciales en 0
        );

        const configID = 'CP' + nuevoIDInventario.substring(2);
        await db.query(
            `INSERT INTO ConfiguracionProducto
             (ID_ConfiguracionProducto, ID_Inventario, ExistenciasMinimas, ExistenciasMaximas)
             VALUES (?, ?, ?, ?)`,
            [configID, nuevoIDInventario, ExistenciasMinimas, ExistenciasMaximas]
        );

        await db.commit();

        res.status(201).json({
            message: 'Materia prima agregada correctamente',
            Clave: Clave
        });

    } catch (error) {
        await db.rollback();
        console.error('Error en /alta-materia-prima:', error);
        res.status(500).json({
            error: 'Error al registrar la materia prima.',
            details: error.sqlMessage || error.message
        });
    }
});

router.get('/inventario-completo', verifyToken, async (req, res) => {
  try {
    const sql = `
      SELECT 
        i.ID_Inventario,
        f.Clave,
        mp.Clave AS ID_MateriaPrima,
        i.Descripcion,
        i.ID_Categoria,
        f.Piezas,
        f.Precio,
        pmp.Costo,
        CASE
            WHEN i.ID_Categoria = 'MP' THEN pmp.Existencias
            ELSE f.Existencias
        END AS Existencias,
        COALESCE(c.ExistenciasMinimas, 0) AS ExistenciasMinimas,
        COALESCE(c.ExistenciasMaximas, 0) AS ExistenciasMaximas
      FROM ProductoInventario i
      LEFT JOIN ProductoFabricado f ON i.ID_Inventario = f.ID_Inventario
      LEFT JOIN MateriaPrima mp ON i.ID_Inventario = mp.ID_Inventario
      LEFT JOIN Proveedor_MateriaPrima pmp ON mp.Clave = pmp.Clave
      LEFT JOIN ConfiguracionProducto c ON i.ID_Inventario = c.ID_Inventario
      ORDER BY CAST(SUBSTR(i.ID_Inventario, 3) AS UNSIGNED);
    `;

    const [rows] = await db.query(sql);
    res.json(rows);
  } catch (error) {
    console.error('Error en la consulta:', error.sqlMessage || error.message);
    res.status(500).json({ error: 'Error al obtener el inventario completo' });
  }
});

router.get('/catalogo', async (req, res) => {
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
      WHERE i.ID_Categoria != 'MP'
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
      return res.status(400).json({ error: 'Clave, Descripción y Categoría son obligatorias.' });
    }

    const [claveExistente] = await db.query(
      `SELECT Clave FROM ProductoFabricado WHERE Clave = ?`,
      [Clave]
    );

    if (claveExistente.length > 0) {
      return res.status(400).json({ error: `La clave "${Clave}" ya existe en el sistema.` });
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
    res.status(500).json({ error: 'Error al registrar el producto.' });
  }
});

router.put('/actualizar-producto/:id', verifyToken, async (req, res) => {
    const idInventario = req.params.id;
    const {
      Descripcion,
      ID_Categoria,
      Precio,
      Piezas,
      Costo, // Nuevo campo para costo de materia prima
      ExistenciasMinimas,
      ExistenciasMaximas
    } = req.body;

    try {
        await db.beginTransaction();

        // Siempre actualizamos la descripción en ProductoInventario
        await db.query(
            `UPDATE ProductoInventario SET Descripcion = ? WHERE ID_Inventario = ?`,
            [Descripcion, idInventario]
        );

        // Siempre actualizamos la configuración de producto
        await db.query(
            `INSERT INTO ConfiguracionProducto (ID_ConfiguracionProducto, ID_Inventario, ExistenciasMinimas, ExistenciasMaximas)
             VALUES (?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE
               ExistenciasMinimas = VALUES(ExistenciasMinimas),
               ExistenciasMaximas = VALUES(ExistenciasMaximas);`,
            ['CP' + idInventario.substring(2), idInventario, ExistenciasMinimas, ExistenciasMaximas]
        );

        // Actualización condicional basada en la categoría
        if (ID_Categoria === 'MP') {
            // Es Materia Prima: actualizamos costo
            await db.query(
                `UPDATE Proveedor_MateriaPrima SET Costo = ? WHERE ID_Inventario = ?`,
                [Costo, idInventario]
            );
        } else {
            // Es Producto Fabricado: actualizamos precio y piezas
            await db.query(
                `UPDATE ProductoFabricado SET Precio = ?, Piezas = ? WHERE ID_Inventario = ?`,
                [Precio, Piezas, idInventario]
            );
        }

        await db.commit();
        res.json({ message: 'Ítem actualizado correctamente' });

    } 
    catch (error) {
        await db.rollback();
        console.error('Error al actualizar producto/materia prima:', error);
        res.status(500).json({ 
            error: 'Error al actualizar el ítem.',
            details: error.sqlMessage || error.message
        });
    }
});


router.delete('/eliminar-producto/:id', verifyToken, async (req, res) => {
    const idInventario = req.params.id;

    try {
        await db.beginTransaction();

        // 1. Verificar si hay movimientos asociados
        const [movimientos] = await db.query('SELECT ID_Movimiento FROM Movimiento WHERE ID_Inventario = ? LIMIT 1', [idInventario]);
        if (movimientos.length > 0) {
            await db.rollback();
            return res.status(409).json({ error: 'No se puede eliminar: el producto tiene movimientos históricos asociados.' });
        }

        // 2. Obtener la categoría del producto
        const [producto] = await db.query('SELECT ID_Categoria FROM ProductoInventario WHERE ID_Inventario = ?', [idInventario]);
        if (producto.length === 0) {
            await db.rollback();
            return res.status(404).json({ error: 'Producto no encontrado.' });
        }
        const { ID_Categoria } = producto[0];

        // 3. Eliminar de tablas dependientes y principales
        if (ID_Categoria === 'MP') {
            // Es Materia Prima
            await db.query('DELETE FROM Proveedor_MateriaPrima WHERE ID_Inventario = ?', [idInventario]);
            await db.query('DELETE FROM MateriaPrima WHERE ID_Inventario = ?', [idInventario]);
        } else {
            // Es Producto Fabricado
            await db.query('DELETE FROM ProductoFabricado WHERE ID_Inventario = ?', [idInventario]);
        }

        // 4. Eliminar de tablas comunes
        await db.query('DELETE FROM ConfiguracionProducto WHERE ID_Inventario = ?', [idInventario]);
        await db.query('DELETE FROM ProductoInventario WHERE ID_Inventario = ?', [idInventario]);

        await db.commit();
        res.json({ message: 'Producto eliminado correctamente' });

    } catch (error) {
        await db.rollback();
        console.error('Error en /eliminar-producto:', error.sqlMessage || error.message);
        res.status(500).json({ 
            error: 'Error al eliminar el producto.',
            details: error.sqlMessage || error.message
        });
    }
});

/* ===== APARTADO DE GESTION ===== */
router.get('/gestion/productos', verifyToken, async (req, res) => {
  try {
    const sql = `
      -- Productos Fabricados
      SELECT 
        i.ID_Inventario AS id,
        f.Clave AS code,
        i.Descripcion AS description,
        f.Existencias AS stock,
        1 AS active
      FROM ProductoInventario i
      JOIN ProductoFabricado f ON i.ID_Inventario = f.ID_Inventario
      
      UNION ALL
      
      -- Materias Primas
      SELECT 
        i.ID_Inventario AS id,
        mp.Clave AS code,
        i.Descripcion AS description,
        pmp.Existencias AS stock,
        1 AS active
      FROM ProductoInventario i
      JOIN MateriaPrima mp ON i.ID_Inventario = mp.ID_Inventario
      JOIN Proveedor_MateriaPrima pmp ON i.ID_Inventario = pmp.ID_Inventario
      
      ORDER BY description ASC;
    `;
    const [rows] = await db.query(sql);
    res.json(rows);
  } catch (error) {
    console.error('Error obteniendo productos para gestion:', error);
    res.status(500).json({ error: 'Error al obtener el listado de inventario.' });
  }
});

// Helper function to send notification emails
async function sendNotificationEmail(subject, title, content) {
    try {
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'plasticoskavesystem@gmail.com',
                pass: process.env.EMAIL_PASSWORD,
            },
        });

        const html = `
        <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f7f9fb; padding:40px; color:#333;">
          <div style="max-width:600px; margin:auto; background:#fff; border-radius:12px; box-shadow:0 5px 15px rgba(0,0,0,0.1); overflow:hidden;">
            <div style="background:#0d6efd; color:#fff; padding:20px; text-align:center;">
              <h2 style="margin:0;">Plásticos KAVE - Sistema de Control Inventario</h2>
            </div>
            <div style="padding:30px;">
              <h3 style="color:#0d6efd; margin-bottom:20px;">${title}</h3>
              ${content}
              <p style="margin-top:30px; font-size:0.9rem; color:#777; text-align:center;">
                Este es un mensaje automático generado por el Sistema de Control Inventario de 
                <strong>Plásticos KAVE S.A. de C.V.</strong>
              </p>
            </div>
            <div style="background:#0d6efd; color:#fff; text-align:center; padding:10px; font-size:0.85rem;">
              © ${new Date().getFullYear()} Plásticos KAVE S.A. de C.V. | Aguascalientes, México
            </div>
          </div>
        </div>
        `;

        await transporter.sendMail({
            from: `"Sistema de Control de Inventario KAVE Sys" <plasticoskavesystem@gmail.com>`,
            to: 'plasticoskavesystem@gmail.com',
            subject,
            html,
        });
        console.log(`Correo de notificación enviado: ${subject}`);
    } catch (error) {
        console.error('Error al enviar correo de notificación:', error);
    }
}

/* ===== Registrar movimiento ===== */
router.post('/gestion/movimiento', verifyToken, async (req, res) => {
    const { ID_Inventario, TipoMovimiento, Cantidad } = req.body;
    const userId = req.user.uid;

    if (!ID_Inventario || !TipoMovimiento || !Cantidad) {
        return res.status(400).json({ error: 'Datos incompletos.' });
    }

    try {
        await db.beginTransaction();

        const [productInfo] = await db.query(
            `SELECT 
                pi.Descripcion, 
                pi.ID_Categoria,
                cp.ExistenciasMinimas,
                cp.ExistenciasMaximas,
                COALESCE(pf.Clave, mp.Clave) AS Clave
             FROM ProductoInventario pi
             LEFT JOIN ConfiguracionProducto cp ON pi.ID_Inventario = cp.ID_Inventario
             LEFT JOIN ProductoFabricado pf ON pi.ID_Inventario = pf.ID_Inventario
             LEFT JOIN MateriaPrima mp ON pi.ID_Inventario = mp.ID_Inventario
             WHERE pi.ID_Inventario = ?`,
            [ID_Inventario]
        );

        if (productInfo.length === 0) {
            await db.rollback();
            return res.status(404).json({ error: 'Producto no encontrado en el inventario general.' });
        }

        const { Descripcion, ID_Categoria, ExistenciasMinimas, ExistenciasMaximas, Clave } = productInfo[0];
        const cantidadNum = Number(Cantidad);
        let stockActual, nuevoStock, updateQuery, queryParams;

        if (ID_Categoria === 'MP') {
            const [mpDetails] = await db.query(
                `SELECT Existencias FROM Proveedor_MateriaPrima WHERE ID_Inventario = ?`,
                [ID_Inventario]
            );

            if (mpDetails.length === 0) {
                await db.rollback();
                return res.status(404).json({ error: 'Materia Prima no encontrada para actualizar stock.' });
            }
            stockActual = mpDetails[0].Existencias;
            
            updateQuery = `UPDATE Proveedor_MateriaPrima SET Existencias = ? WHERE ID_Inventario = ?`;

        } else {
            const [pfDetails] = await db.query(
                `SELECT Existencias, Clave FROM ProductoFabricado WHERE ID_Inventario = ?`,
                [ID_Inventario]
            );

            if (pfDetails.length === 0) {
                await db.rollback();
                return res.status(404).json({ error: 'Producto fabricado no encontrado para actualizar stock.' });
            }
            stockActual = pfDetails[0].Existencias;

            updateQuery = `UPDATE ProductoFabricado SET Existencias = ? WHERE ID_Inventario = ?`;
        }

        if (TipoMovimiento.toLowerCase() === 'entrada') {
            nuevoStock = stockActual + cantidadNum;
        } else if (TipoMovimiento.toLowerCase() === 'salida') {
            if (stockActual < cantidadNum) {
                await db.rollback();
                return res.status(400).json({ error: 'Stock insuficiente para la salida.' });
            }
            nuevoStock = stockActual - cantidadNum;
        } else {
            await db.rollback();
            return res.status(400).json({ error: 'Tipo de movimiento no válido.' });
        }
        queryParams = [nuevoStock, ID_Inventario];

        const [rows] = await db.query('SELECT COUNT(*) AS total FROM Movimiento');
        const nuevoIdMovimiento = 'MOV' + (rows[0].total + 1).toString().padStart(3, '0');

        await db.query(
            `INSERT INTO Movimiento (ID_Movimiento, ID_Usuario, ID_Inventario, Fecha, TipoMovimiento, Cantidad)
             VALUES (?, ?, ?, NOW(), ?, ?)`,
            [nuevoIdMovimiento, userId, ID_Inventario, TipoMovimiento, cantidadNum]
        );

        await db.query(updateQuery, queryParams);

        await db.commit();

        // Lógica de notificación por correo
        if (ExistenciasMinimas != null && ExistenciasMaximas != null) {
            let alertSubject = null;
            let alertTitle = null;
            let alertContent = null;

            if (nuevoStock < ExistenciasMinimas) {
                alertSubject = ID_Categoria === 'MP' ? '⚠️ Alerta de Desabasto de Materia Prima' : '⚠️ Alerta de Desabasto de Producto';
                alertTitle = ID_Categoria === 'MP' ? 'Desabasto de Materia Prima' : 'Desabasto de Producto';
                alertContent = `
                    <p>El producto <strong>${Descripcion}</strong> (Clave: ${Clave}) ha caído por debajo del umbral mínimo de existencias.</p>
                    <table style="width:100%; border-collapse:collapse; margin-bottom:20px; text-align: left;">
                    <tr><td style="padding:8px; font-weight:600; width:40%;">Stock Actual:</td><td style="padding:8px; background:#f3f6f9; color:red; font-weight:bold;">${nuevoStock}</td></tr>
                    <tr><td style="padding:8px; font-weight:600;">Stock Mínimo:</td><td style="padding:8px; background:#f3f6f9;">${ExistenciasMinimas}</td></tr>
                    </table>
                    <p>Se recomienda tomar acciones para reabastecer el inventario.</p>
                `;
            } else if (nuevoStock > ExistenciasMaximas) {
                alertSubject = ID_Categoria === 'MP' ? '📈 Alerta de Exceso de Materia Prima' : '📈 Alerta de Sobreproducción de Producto';
                alertTitle = ID_Categoria === 'MP' ? 'Exceso de Materia Prima' : 'Sobreproducción de Producto';
                alertContent = `
                    <p>El producto <strong>${Descripcion}</strong> (Clave: ${Clave}) ha superado el umbral máximo de existencias.</p>
                    <table style="width:100%; border-collapse:collapse; margin-bottom:20px; text-align: left;">
                    <tr><td style="padding:8px; font-weight:600; width:40%;">Stock Actual:</td><td style="padding:8px; background:#f3f6f9; color:blue; font-weight:bold;">${nuevoStock}</td></tr>
                    <tr><td style="padding:8px; font-weight:600;">Stock Máximo:</td><td style="padding:8px; background:#f3f6f9;">${ExistenciasMaximas}</td></tr>
                    </table>
                    <p>Se recomienda revisar los niveles de producción o compra.</p>
                `;
            }

            if (alertSubject && alertTitle && alertContent) {
                sendNotificationEmail(alertSubject, alertTitle, alertContent);
            }
        }
        
        res.status(201).json({
            message: `Movimiento de ${TipoMovimiento} registrado.`,
            id: nuevoIdMovimiento,
            stockActualizado: nuevoStock,
        });

    } catch (error) {
        await db.rollback();
        console.error('Error registrando movimiento:', error);
        res.status(500).json({ error: 'Error interno al registrar el movimiento.' });
    }
});

/* ===== Últimos movimientos ===== */
router.get('/gestion/movimientos', verifyToken, async (req, res) => {
  try {
    const sql = `
      SELECT
        m.ID_Movimiento,
        m.ID_Inventario,
        -- Determinar la clave (código) del producto
        CASE pi.ID_Categoria
          WHEN 'MP' THEN mp.Clave
          ELSE pf.Clave
        END AS CodigoProducto,
        pi.Descripcion AS Producto,
        m.Fecha,
        m.TipoMovimiento AS Tipo,
        m.Cantidad,
        -- Determinar el stock actual del producto desde la tabla correcta
        CASE pi.ID_Categoria
          WHEN 'MP' THEN pmp.Existencias
          ELSE pf.Existencias
        END AS StockActual,
        u.Nombre AS NombreUsuario
      FROM Movimiento m
      JOIN ProductoInventario pi ON m.ID_Inventario = pi.ID_Inventario
      LEFT JOIN ProductoFabricado pf ON pi.ID_Inventario = pf.ID_Inventario
      LEFT JOIN MateriaPrima mp ON pi.ID_Inventario = mp.ID_Inventario
      LEFT JOIN Proveedor_MateriaPrima pmp ON mp.Clave = pmp.Clave AND pi.ID_Inventario = pmp.ID_Inventario
      LEFT JOIN Usuario u ON m.ID_Usuario = u.ID_Usuario
      ORDER BY m.Fecha DESC, m.ID_Movimiento DESC
      LIMIT 50;
    `;

    const [rows] = await db.query(sql);

    const movimientos = rows.map((m) => ({
      ID_Movimiento: m.ID_Movimiento,
      ID_Inventario: m.ID_Inventario,
      CodigoProducto: m.CodigoProducto,
      Producto: m.Producto,
      Fecha: new Date(m.Fecha).toISOString(),
      Tipo: m.Tipo,
      Cantidad: m.Cantidad,
      StockActual: m.StockActual,
      NombreUsuario: m.NombreUsuario || '—',
    }));

    res.json(movimientos);
  }
  catch(error) {
    console.error('Error obteniendo movimientos:', error);
    res.status(500).json({ error: 'Error al obtener movimientos.' });
  }
});


module.exports = router;