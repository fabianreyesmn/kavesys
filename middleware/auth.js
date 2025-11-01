//Proteger los Endpoints del Backend para que solo los usuarios autenticados puedan acceder
const admin = require('firebase-admin');

const serviceAccount = require('../serviceAccountKey.json'); //Clave privada de servicio de Firebase: Configuración de proyecto > Cuentas de servicio > Generar nueva clave privada

if(!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });
}

//Middleware para verificar el token de ID de Firebase.
//Si el token es válido se agrega la información del usuario a req.user, si no envía una respuesta de error 403.
async function verifyToken(req, res, next) {
    const authHeader = req.headers.authorization;

    if(!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).send({ error: 'No autorizado. Token no proporcionado.' });
    }

    const idToken = authHeader.split('Bearer ')[1];

    try {
        const decodedToken = await admin.auth().verifyIdToken(idToken); //Verificación del token utilizando firebase-admin
    
        //El token es válido, se adjunta el usuario decodificado (que incluye el uid) al objeto 'req' para que esté disponible en las siguientes rutas
        req.user = decodedToken;
        
        next(); //Continuación a la siguiente función (la ruta solicitada)
    } 
    catch(error) {
        console.error('Error al verificar el token:', error);
        return res.status(403).send({ error: 'Token inválido o expirado.' });
    }
}

module.exports = { verifyToken };