create database ecommerce;

use ecommerce;

CREATE TABLE categorias (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL
);

CREATE TABLE usuarios (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL,
  correo varchar(100) UNIQUE NOT NULL,
  contrasena TEXT NOT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE productos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL,
  categoria_id BIGINT,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE pedidos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  usuario_id BIGINT NOT NULL,
  fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total DECIMAL(10, 2) NOT NULL,
  estado TEXT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE detalles_pedidos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  pedido_id BIGINT NOT NULL,
  producto_id BIGINT NOT NULL,
  cantidad INT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

ALTER TABLE productos
ADD COLUMN en_oferta BOOLEAN DEFAULT FALSE;

ALTER TABLE productos
ADD COLUMN descuento DECIMAL(5, 2) DEFAULT 0.00;

ALTER TABLE productos
ADD COLUMN tags JSON;

ALTER TABLE productos
ADD COLUMN marca TEXT,
ADD COLUMN modelo TEXT,
ADD COLUMN material TEXT,
ADD COLUMN popularidad DECIMAL(3, 2) DEFAULT 0.00;

CREATE TABLE marcas (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL
);

CREATE TABLE modelos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL,
  marca_id BIGINT,
  FOREIGN KEY (marca_id) REFERENCES marcas(id)
);

CREATE TABLE materiales (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT NOT NULL
);

ALTER TABLE productos
DROP COLUMN marca,
DROP COLUMN modelo,
DROP COLUMN material,
ADD COLUMN marca_id BIGINT,
ADD COLUMN modelo_id BIGINT,
ADD COLUMN material_id BIGINT,
ADD FOREIGN KEY (marca_id) REFERENCES marcas(id),
ADD FOREIGN KEY (modelo_id) REFERENCES modelos(id),
ADD FOREIGN KEY (material_id) REFERENCES materiales(id);