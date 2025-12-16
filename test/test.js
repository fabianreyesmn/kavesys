const request = require('supertest');
const app = require('../index');
const db = require('../db');

describe('GET /', () => {
  it('Responde con un código de estado 200', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
  });
});

afterAll(async () => {
  await db.end();
});